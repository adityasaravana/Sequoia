//
//  EmailDataController.swift
//  Sequoia
//
//  Created by Saravana Rathinam on 12/29/23.
//

import CoreData
import Foundation
import MailCore

class DataController {
    private var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func fetchNewEmailsForAccount(account: Account, with folder: String) {
        let fetchOperation = account.imap.fetchMessagesOperation(withFolder: folder, 
                                                                 requestKind: .headers,
                                                                 uids: MCOIndexSet(range: MCORangeMake(1, UINT64_MAX)))
        fetchOperation?.start { [weak self] error, messages, _ in
            if let error = error {
                print("Error fetching emails: \(error)")
                return
            }
            guard let self = self, let messages = messages else { return }
            
            // And, let's print out the messages:
            print("The post man delivereth: \(messages.debugDescription)")
            for message in messages {
                self.processEmail(message: message as MCOIMAPMessage, for: account)
            }
        }
    }
    
    private func processEmail(message: MCOIMAPMessage, for account: Account) {
        let fetchRequest: NSFetchRequest<EmailEntity> = EmailEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %ld", message.uid)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if results.isEmpty {
                let newEmail = EmailEntity(context: managedObjectContext)
                newEmail.uid = Int64(message.uid)
                newEmail.sequenceNumber = Int64(message.sequenceNumber)
                // Map flags
                newEmail.flagSeen = message.flags.contains(.seen)
                newEmail.flagAnswered = message.flags.contains(.answered)
                newEmail.flagFlagged = message.flags.contains(.flagged)
                newEmail.flagDeleted = message.flags.contains(.deleted)
                newEmail.flagDraft = message.flags.contains(.draft)
                newEmail.flagMDNSent = message.flags.contains(.mdnSent)
                newEmail.flagForwarded = message.flags.contains(.forwarded)
                newEmail.flagSubmitPending = message.flags.contains(.submitPending)
                newEmail.flagSubmitted = message.flags.contains(.submitted)
                
                // Fetch and save the email body
                fetchAndSaveEmailBody(for: newEmail, with: message.uid, with:account)
                
                try managedObjectContext.save()
            } else {
                print("Email with uid \(message.uid) already processed.")
            }
        } catch {
            print("Error processing email: \(error)")
        }
    }

    private func fetchAndSaveEmailBody(for emailEntity: EmailEntity, with uid: UInt32, with account: Account) {
        let operation = account.imap.fetchMessageOperation(withFolder: "INBOX", uid: uid)
        operation?.start { [weak self] error, data in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching email body: \(error)")
            } else if let data = data, let messageParser = MCOMessageParser(data: data) {
                let body = messageParser.htmlBodyRendering() ?? messageParser.plainTextBodyRendering() ?? ""
                let bodyFilePath = self.saveBodyToFile(body: body)
                DispatchQueue.main.async {
                    emailEntity.bodyFileReference = bodyFilePath
                    try? self.managedObjectContext.save()
                }
            }
        }
    }
    
    private func saveBodyToFile(body: String) -> String {
        let filename = UUID().uuidString + ".html"
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try body.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL.path
        } catch {
            print("Error saving email body to file: \(error)")
            return ""
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
