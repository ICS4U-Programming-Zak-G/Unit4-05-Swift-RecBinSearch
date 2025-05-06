//
//  RecBinSearch.swift
//
//  Created by Zak Goneau
//  Created on 2025-05-04
//  Version 1.0
//  Copyright (c) 2025 Zak Goneau. All rights reserved.
//
//  This program uses recursion find numbers in an array by performing binary search.

// Import library
import Foundation

// Define main function
func main() {

    // Introduce program
    print("This program uses recursion to find a number in an array through binary search.")
    print("The output will be displayed in the output.txt file")

    // Assign file names
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Declare index result
    var index = 0

    // Initialize low
    let low = 0

    // Declare array to hold input
    var inputArray = [String]()

    // Initialize output string
    var outputStr = ""

    // Try to read the input file
    guard let input = FileHandle(forReadingAtPath: inputFile) else {

        // Tell user input file couldn't be opened
        print("Couldn't open input file")

        // Exit function
        exit(1)
    }

    // Try to read the output file
    guard let output = FileHandle(forWritingAtPath: outputFile) else {

        // Tell user output file couldn't be opened
        print("Couldn't open output file")

        // Exit function
        exit(1)
    }

    // Read lines from input file
    let inputData = input.readDataToEndOfFile()

    // Convert data to string
    guard let inputString = String(data: inputData, encoding: .utf8) else {

        // Tell user couldn't convert data to string
        print("Couldn't convert data to string")

        // Exit function
        exit(1)
    }

    // Split string by new lines
    let lines = inputString.components(separatedBy: "\n")

    // Initialize position in file
    var position = 0

    // Loop through lines
    while position < lines.count-1 {
        // Split line and get array
        let arrayLine = lines[position].trimmingCharacters(in: .whitespaces)

        // Skip to next position, split line, and get search line
        let searchLine = lines[position + 1].trimmingCharacters(in: .whitespaces)

        // Check if either line is empty
        if (arrayLine.isEmpty || searchLine.isEmpty) {
            // Add to output string
            outputStr += "The array or search number is empty.\n"

            // Continue to next line
            position += 2

            // Continue to next iteration
            continue
        }

        // Assign line to array
        inputArray = arrayLine.components(separatedBy: " ")

        // Initialize int array
        var intArray = [Int]()

        // Successfully parsed array bool
        var parsedArray = true

        // Fill int array with values
        for counter in 0..<inputArray.count {
            // Cast string to int
            if let num = Int(inputArray[counter]) {
                // Add to int array
                intArray.append(num)
            } else {
                // Add to output string
                outputStr += "The array must only contain integers.\n"

                // Set parsed array to false
                parsedArray = false

                // break out of loop
                break
            }
        }

        // Try parsing search number
        guard let searchNum = Int(searchLine) else {
            // Add to output string
            outputStr += "The search number must be an integer.\n"

            // Continue to next line
            position += 2

            // Continue to next iteration
            continue
        }

        // Check if array was parsed successfully
        if (parsedArray == true) {
            // Sort array
            intArray.sort()

            // Call function to find index
            index = recBinSearch(array: intArray, searchNum: searchNum, low: low, high: intArray.count - 1)

            // Add sorted array to output string
            outputStr += "Sorted array: \(intArray)\n"

            // Check if number wasn't found
            if (index == -1) {
                // Add to output string
                outputStr += "The number \(searchNum) was not found in the array.\n"

            // Otherwise number was found
            } else {
                // Add to output string
                outputStr += "The number \(searchNum) was found at index \(index).\n"
            }
        }

        // Increment to next line
        position += 2
    }

    // Write to output file
    output.write(outputStr.data(using: .utf8)!)

    // Print success message
    print("Success, results written to output file.")

    // Close files
    output.closeFile()
    input.closeFile()
}

// Define function to find a number in an array using recursion by binary search
func recBinSearch(array: [Int], searchNum: Int, low: Int, high: Int) -> Int {

    // Set base case if low is greater than high
    if (low > high) {
        // Return error value, not found
        return -1
    }

    // Find middle point
    let mid = (low + high) / 2

    // Check if number is equal to middle point
    if (array[mid] == searchNum) {
        // Return index
        return mid

    // Check if number is greater than middle point
    } else if (array[mid] < searchNum) {
        // Call function recursively with new low
        return recBinSearch(array: array, searchNum: searchNum, low: mid + 1, high: high)

    // Otherwise, number is less than middle point
    } else {
        // Call function recursively with new high
        return recBinSearch(array: array, searchNum: searchNum, low: low, high: mid - 1)
    }
}

// Call main
main()