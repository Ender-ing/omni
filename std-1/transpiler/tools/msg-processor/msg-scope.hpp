/**
 * This file contains the definitions needed to manage the process of scaning
 * the messages scope folders!
**/

#include <boost/filesystem.hpp>
#include <iostream>
#include "../process-reports/main.hpp"

// in progress...

// All elements related to the processing of the message scope folders
// are placed within this namespace!
namespace msg_scope_processor {

    // Used namespace shortcuts
    namespace fs = boost::filesystem;
    namespace reports = process_reports;

    // The errors object!
    reports::ProcessReport process_report ();

    /**
     * Scan a scope directory
     * 
     * This function is used to scan the scope directory that contains the
     * text message files and .ini configuration file for the scope!
     * 
     * @param dir_path_string <std::string> The path of the scope folder!
     * 
     * @return 0 - If no errors occurred
     * @return 1 - If an error occurred (check the process_error object for details)
    **/
    int scan_scope_directory (std::string dir_path_string) {
        // Get the proper directory path
        fs::path dir_path(dir_path_string);

        // Check if the directory exists and is a directory
        if (fs::is_directory(dir_path)) {

            // Copy all objects relating to this folder
            std::vector<fs::directory_entry> entries;
            for (auto &entry : fs::directory_iterator(dir_path)) {
                entries.push_back(entry);
            }
            // Sort the entries alphabetically by filename (using a Lambda expression)
            std::sort(entries.begin(), entries.end(), [](const fs::directory_entry& a, const fs::directory_entry& b) {
                return a.path().filename() < b.path().filename();
            });

            // Go through the contents of the directory alphabetically
            // (this is done to ensure that the configuration file is loaded first!)
            for (const auto& entry : entries) {
                // Check if this is a file
                if (fs::is_regular_file(entry)) {
                    // Get file info
                    const std::string current_full_path = entry.path().string();
                    const std::string current_file_extension = entry.path().extension().string();
                    const std::string current_file_name = entry.path().filename().string();

                    // Start check the file's info
                    // Check for .txt files
                    if (current_file_extension == "txt") {
                        // Check if the file name only consists of one character
                        // X.txt -> 5 characters!
                        if (entry.path().filename().string().length() == 5) {
                            // This is a messages .txt file
                            scan_message_txt_content(current_full_path);
                        } else {
                            // Oh no, you where not supposed to have this file in here!
                            "Only message (.txt) files that follow the proper naming scheme are allowed! (X.txt)";
                            return 1;
                        }
                    } else if (current_file_extension == "ini") { // Check for the .ini file!
                        // Check if this is indeed the expected .ini file!
                        if (current_file_name == ".ini") {
                            // This is the .ini configuration file
                            scan_scope_configuration_ini_content(current_full_path);
                        } else {
                            // You where not supposed to have this file in here!
                            "Only expecting one configuration (.ini) file for the scope!";
                            return 1;
                        }
                    } else { // This is an unexpected file!
                        // You where not supposed to have this file in here!
                        "Only expecting either a configuration (.ini) file or message (.txt) files for the scope!";
                        return 1;
                    }
                } else {
                    // You where no supposed to have this folder in here!
                }
            }
        } else {
            std::cerr << "Error: " << dir_path.string() << " is not a directory." << std::endl;
        }

        return 0;
    }

    /**
     * Scan the contents of a messages (.txt) file
     * 
     * This function is used to scan the contents of the message (.txt) file
     * that contains the messages for its specific type!
     * 
     * @param file_path_string <std::string> The path of the messages (.txt) file!
     * 
     * @return 0 - If no errors occurred
     * @return 1 - If an error occurred (check the process_error object for details)
    **/
    int scan_message_txt_content (std::string file_path_string) {
        // ...
        return 0;
    }

    /**
     * Scan the contents of the scope configuration (.ini) file
     * 
     * This function is used to scan the contents of the configuration (.ini) file
     * that contains the configurations for the scope folder!
     * 
     * @param file_path_string <std::string> The path of the messages (.txt) file!
     * 
     * @return 0 - If no errors occurred
     * @return 1 - If an error occurred (check the process_error object for details)
    **/
    int scan_scope_configuration_ini_content (std::string file_path_string) {
        // ...
        return 0;
    }

}


/*
// Reading files:

std::ifstream file(path_string);
 
std::string line;
while (std::getline(file, line)) {
    std::cout << line << std::endl;
}

*/
