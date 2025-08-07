package com.login.visualizationsoftware.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class CsvParser {

    /**
     * Reads a CSV file, extracts data from specified columns, and returns a sorted, limited map.
     * @param filePath The full path to the CSV file.
     * @param labelIndex The column index for the labels.
     * @param valueIndex The column index for the numerical values.
     * @param limitCount The maximum number of records to return.
     * @return A Map sorted by value in descending order.
     */
    public static Map<String, Double> parse(String filePath, int labelIndex, int valueIndex, int limitCount) throws IOException {
        Map<String, Double> dataMap = new LinkedHashMap<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            boolean isHeader = true;

            // Read the file line by line
            while ((line = br.readLine()) != null) {
                // Skip the first line (header)
                if (isHeader) {
                    isHeader = false;
                    continue;
                }

                String[] tokens = line.split(",");
                if (tokens.length > labelIndex && tokens.length > valueIndex) {
                    String label = tokens[labelIndex].trim();
                    try {
                        // Try to parse the value as a number
                        double value = Double.parseDouble(tokens[valueIndex].trim());
                        // Add the value to the map, summing if the label already exists
                        dataMap.put(label, dataMap.getOrDefault(label, 0.0) + value);
                    } catch (NumberFormatException e) {
                        // This will ignore rows where the value column isn't a valid number.
                        System.err.println("Could not parse value in row, skipping: " + line);
                    }
                }
            }
        }

        // Use a Java Stream to sort the map by its values in descending order,
        // limit the results, and collect them into a new LinkedHashMap to preserve order.
        return dataMap.entrySet().stream()
                .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
                .limit(limitCount)
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));
    }
}