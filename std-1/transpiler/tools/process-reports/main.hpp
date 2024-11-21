/**
 * This file contains the definitions needed to manage process errors and whatnot!
**/

#include <string>
#include <vector>
#include <iostream>
#include <ctime>

// in progress...

// All error reporting related definitions
namespace process_reports {

    // Report types
    enum ReportType {
        Error = 1,
        Warning = 2,
        Info = 3
    };

    // The process reports object (for errors and such)
    class ProcessReport {
    public:
        ProcessReport() {
            // No nothing, this is an object that is meant to be edited!
        }
        ProcessReport(const std::string& message, const std::string& file, int line) {
            this->message = message;
            this->file = file;
            this->line = line;
            checkTimestamp();
        }

        // Set & Get Message Type
        void setType(ReportType type) {
            this->type = type;
            checkTimestamp();
        }
        ReportType getType() const {
            return this->type;
        }

        // Set & Get Message
        void setMessage(std::string message) {
            this->message = message;
            checkTimestamp();
        }
        std::string getMessage() const {
            return message;
        }

        // Set & Get File path
        void setFile(std::string file) {
            this->file = file;
            checkTimestamp();
        }
        std::string getFile() const {
            return file;
        }

        // Set & Get Line number
        void setLine(int line) {
            this->line = line;
            checkTimestamp();
        }
        int getLine() const {
            return line;
        }

        // Get the timestamp
        std::string getTimestamp() const {
            std::tm* tm = std::localtime(&timestamp);
            char buffer[26];
            std::strftime(buffer, 26, "%Y-%m-%d %H:%M:%S", tm);
            return buffer;
        }

    private:
        ReportType type;
        std::string message;
        std::string file;
        int line;
        time_t timestamp;
        void checkTimestamp() {
            if (this->timestamp == 0) {
                this->timestamp = std::time(nullptr);
            }
        }
    };
}
