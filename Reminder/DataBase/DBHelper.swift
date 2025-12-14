//
//  DBHelper.swift
//  Reminder
//
//  Created by NJ Development on 23/10/25.
//

import Foundation
import SQLite3

public class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?

    private init() {
        openDataBase()
        createTable()
    }

    private func openDataBase() {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("Reminder.sqlite")

            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("error opening database")
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

    private func createTable() {
        let query = """
            CREATE TABLE IF NOT EXISTS Prescriptions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                medicine TEXT,
                time TEXT,
                recurrence TEXT,
                takeNow INTEGER
            );
            """

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Prescriptions table created.")
            } else {
                print("Erro ao criar a tabela")
            }
        } else {
            print("Não executou statement")
        }
        sqlite3_finalize(statement)
    }

    func insertPrescription(prescription: Prescription, shouldTakeItNow: Bool) -> Int? {
        let query = "INSERT INTO Prescriptions (medicine, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"

        var statement: OpaquePointer?
        var insertedId: Int?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            let medicineCString = (prescription.medicine as NSString).utf8String
            let timeCString = (prescription.time as NSString).utf8String
            let recurrenceCString = (prescription.recurrence.rawValue as NSString).utf8String
            sqlite3_bind_text(statement, 1, medicineCString, -1, nil)
            sqlite3_bind_text(statement, 2, timeCString, -1, nil)
            sqlite3_bind_text(statement, 3, recurrenceCString, -1, nil)
            sqlite3_bind_int(statement, 4, shouldTakeItNow ? 1 : 0)

            if sqlite3_step(statement) == SQLITE_DONE {
                insertedId = Int(sqlite3_last_insert_rowid(db))
                print("Prescription inserted with ID: \(insertedId ?? -1)")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("Failed to insert prescription: \(errmsg)")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Failed to prepare insert: \(errmsg)")
        }
        sqlite3_finalize(statement)
        return insertedId
    }

    func fetchPrescriptions() -> [Prescription] {
        let query = "SELECT * FROM Prescriptions;"
        var statement: OpaquePointer?
        var prescriptions: [Prescription] = []

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let medicine = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) } ?? "Unknown"
                let time = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) } ?? "Unknown"
                let recurrence = sqlite3_column_text(statement, 3).flatMap { String(cString: $0) } ?? "Unknown"
                _ = sqlite3_column_int(statement, 4)
                prescriptions.append(Prescription(id: id, medicine: medicine, time: time, recurrence: RecurrenceOptions(rawValue: recurrence) ?? .onceADay))
            }
        } else {
            print("SELECT failed")
        }

        sqlite3_finalize(statement)
        return prescriptions
    }

    func deletePrescription(by id: Int) {
        let query = "DELETE FROM Prescriptions WHERE id = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Prescription deleted")
            } else {
                print("Could not delete prescription")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("DELETE prepare failed: \(errmsg)")
        }

        sqlite3_finalize(statement)
    }

    func updatePrescription(_ prescription: Prescription, shouldTakeItNow: Bool) {
        guard let id = prescription.id else {
            print("Cannot update prescription without ID")
            return
        }
        let query = "UPDATE Prescriptions SET medicine = ?, time = ?, recurrence = ?, takeNow = ? WHERE id = ?;"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            let medicineCString = (prescription.medicine as NSString).utf8String
            let timeCString = (prescription.time as NSString).utf8String
            let recurrenceCString = (prescription.recurrence.rawValue as NSString).utf8String
            sqlite3_bind_text(statement, 1, medicineCString, -1, nil)
            sqlite3_bind_text(statement, 2, timeCString, -1, nil)
            sqlite3_bind_text(statement, 3, recurrenceCString, -1, nil)
            sqlite3_bind_int(statement, 4, shouldTakeItNow ? 1 : 0)
            sqlite3_bind_int(statement, 5, Int32(id))

            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("Failed to update prescription: \(errmsg)")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("Failed to prepare update: \(errmsg)")
        }
        sqlite3_finalize(statement)
    }
}
