# G2Code

This repository contains G-code files for a CNC machine, specifically designed for an automated sorting system. The primary G-code file, `MakoyaCode.gcode`, orchestrates the picking, color sensing, and depositing of 36 parts into designated bins.

## Features

*   **Automated Sorting:** Sorts up to 36 parts based on dominant color.
*   **Color Sensing Logic:** Implements a robust dominant color detection algorithm to accurately classify parts, preventing misidentification (e.g., yellow not being mistaken for red).
*   **Configurable Bins:** Supports distinct bins for Red, Green, Blue, and a Reject category.
*   **Absolute Positioning:** Utilizes absolute positioning (`G90`) for precise movement control.
*   **Metric Units:** Operates in metric units (`G21`).
*   **Cycle Looping:** Ensures the full cycle repeats until the target number of parts (36) is processed.
*   **Safe Reject Bin:** Defaults to the reject bin for any unclassified or problematic parts.
*   **Consistent Retract Path:** Employs a fixed retract path for reliability.
*   **Vacuum Control:** Integrates vacuum control (`M05`) for part gripping.
*   **Conveyor Control:** Manages conveyor operation (`M03`).

## Setup Instructions

1.  **Download Repository:** Clone or download the contents of this repository to your local machine.
2.  **Transfer G-Code:** Copy the desired G-code files (e.g., `MakoyaCode.gcode`) to your CNC machine's control system.
3.  **Configure Machine Parameters:**
    *   Ensure your CNC machine is set to **Absolute Positioning** (`G90`) and **Metric Units** (`G21`).
    *   Verify that the G-code interpreter supports macro variables (e.g., `#100`, `#111`, etc.) and subprogram calls (`O100`, `O900`).
    *   **Crucially, calibrate the color sensor inputs (`AI1`, `AI2`, `AI3`) and adjust the `Color sensor threshold` (`#112`) parameter in the G-code file to match your specific lighting conditions and sensor sensitivity.**
    *   Confirm that the bin center X-coordinates (`#130`, `#131`, `#132`, `#133`) and the pick position X-coordinate (`#120`) are accurately set for your machine's workspace.
4.  **Load and Run:** Load the selected G-code file into your CNC machine's controller and initiate the program.

## Technology Stack

*   **G-Code:** The primary programming language for CNC machine control.
*   **CNC Controller:** Assumes a controller capable of handling macro variables, conditional logic (`IF/GOTO`), and subprograms.
*   **Color Sensor:** An analog color sensor providing Red, Green, and Blue channel readings.
*   **Vacuum Gripper:** A pneumatic or electric gripper with vacuum control.
*   **Conveyor System:** A material handling conveyor with a part-present sensor.

## Visual Badges

[![G-Code](https://img.shields.io/badge/G--Code-FF0000?style=for-the-badge&logo=github)](https://github.com/datoxic0/g2Code)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)