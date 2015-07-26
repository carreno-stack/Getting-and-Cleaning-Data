# Getting and Cleaning Data - Final Project CodeBook

*For more information refer to the [README.md](https://github.com/dacarrenog/Getting-and-Cleaning-Data/blob/master/README.md) file.

### 1. Intermediate variables/definitions

1. **train** [data frame]: Contains merged training results raw data. Dimensions: 7352 x 563
    - First column: Subject ID.
    - Columns 2-562: Raw variables without filtering/treatment from the train/X_train.txt file.
    - Column 563: Activity ID.

2. **test** [data frame]: Contains merged test results raw data. Dimensions: 2947 x 563
    - First column: Subject ID.
    - Columns 2-562: Raw variables without filtering/treatment from the test/X_test.txt file.
    - Column 563: Activity ID.

3. **dataset** [data frame]: Contains train and test merged together. Dimensions: 10299 x 563
    - First column: Subject ID.
    - Columns 2-562: Raw variables without filtering/treatment from the test/X_test.txt file. Only 79 of these variables will remain in the final data set. See details for the *cleandataset* data frame below.
    - Column 563: Activity ID.

4. **labels** [data frame]: Contains column number for features vector and raw labels for each column. Obtained from the "features.txt" file. Dimensions: 561 x 2
    -First column: column number/index
    -Second column: variable raw label

5. **meanstd** [numeric vector]: Contains column index number of the variables in the features vector that contain "mean" or "std". Length: 79

6. **cleandataset** [data frame]: Contains the train and test data sets merged together, including only variables that contain "mean" or "std". Dimensions: 10299 x 82
    - First column: Subject ID.
    - Columns 2-80: Variables related to "mean" or "std".

        Angular variables such as angle(tBodyAccMean,gravity) are not included. The reason is that although they include the word "Mean" you can see that the mean is passed as a parameter to a function, but what is being returned is an angle, not a mean and/or standard variation making it irrelevant for our purposes. You can find more details about the final description for each variable in section 2 **"Final Table"**.
        
    - Column 81: Activity ID.
    - Column 82: Activity name.

7. **activity** [data frame]: Contains activity ID and its corresponsing activity name. Loaded from the "activity_labels.txt" file. Dimensions: 6 x 2.
    
    Codes:

    1.WALKING
    
    2.WALKING_UPSTAIRS
    
    3.WALKING_DOWNSTAIRS
    
    4.SITTING
    
    5.STANDING
    
    6.LAYING


### 2. Final Table
The tidy data is contained on the *finaldata* data frame. Dimensions: 180x82. Description of the 82 columns:

1. **subject**: Subject ID, 30 different unique subjects.
2. **activity_ID**: Activity ID (numeric). There are 6 Different activities and *activity_ID* includes the corresponding number.
    
    1.WALKING
    
    2.WALKING_UPSTAIRS
    
    3.WALKING_DOWNSTAIRS
    
    4.SITTING
    
    5.STANDING
    
    6.LAYING
3. **activity**: Activity name. There are 6 Different activities and *activity* includes the corresponding name.
    
    1.WALKING
    
    2.WALKING_UPSTAIRS
    
    3.WALKING_DOWNSTAIRS
    
    4.SITTING
    
    5.STANDING
    
    6.LAYING
4. **[Time]Average_Body_Acceleration_Mean_X_Axis**: Average body acceleration mean for Axis X per subject and activity. Units: standard 'g' [m/s^2]
5. **[Time]Average_Body_Acceleration_Mean_Y_Axis**: Average body acceleration mean for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
6. **[Time]Average_Body_Acceleration_Mean_Z_Axis**: Average body acceleration mean for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
7. **[Time]Average_Body_Acceleration_StdDev_X_Axis**: Average body acceleration StdDev for Axis X per subject and activity. Units: standard 'g' [m/s^2]
8. **[Time]Average_Body_Acceleration_StdDev_Y_Axis**: Average body acceleration StdDev for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
9. **[Time]Average_Body_Acceleration_StdDev_Z_Axis**: Average body acceleration StdDev for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
10. **[Time]Average_Gravity_Acceleration_Mean_X_Axis**: Average gravity acceleration mean for Axis X per subject and activity. Units: standard 'g' [m/s^2]
11. **[Time]Average_Gravity_Acceleration_Mean_Y_Axis**: Average gravity acceleration mean for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
12. **[Time]Average_Gravity_Acceleration_Mean_Z_Axis**: Average gravity acceleration mean for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
13. **[Time]Average_Gravity_Acceleration_StdDev_X_Axis**: Average gravity acceleration StdDev for Axis X per subject and activity. Units: standard 'g' [m/s^2]
14. **[Time]Average_Gravity_Acceleration_StdDev_Y_Axis**: Average gravity acceleration StdDev for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
15. **[Time]Average_Gravity_Acceleration_StdDev_Z_Axis**: Average gravity acceleration StdDev for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
16. **[Time]Average_Body_Linear_Jerk_Mean_X_Axis**: Average body linear jerk mean for Axis X per subject and activity. Units: 'g/s' [m/s^3]
17. **[Time]Average_Body_Linear_Jerk_Mean_Y_Axis**: Average body linear jerk mean for Axis Y per subject and activity. Units: 'g/s' [m/s^3]
18. **[Time]Average_Body_Linear_Jerk_Mean_Z_Axis**: Average body linear jerk mean for Axis Z per subject and activity. Units: 'g/s' [m/s^3]
19. **[Time]Average_Body_Linear_Jerk_StdDev_X_Axis**: Average body linear jerk StdDev for Axis X per subject and activity. Units: 'g/s' [m/s^3]
20. **[Time]Average_Body_Linear_Jerk_StdDev_Y_Axis**: Average body linear jerk StdDev for Axis Y per subject and activity. Units: 'g/s' [m/s^3]
21. **[Time]Average_Body_Linear_Jerk_StdDev_Z_Axis**: Average body linear jerk StdDev for Axis Z per subject and activity. Units: 'g/s' [m/s^3]
22. **[Time]Average_Body_Angular_Speed_Mean_X_Axis**: Average body angular speed mean for Axis X per subject and activity. Units: radians/second [rad/s]
23. **[Time]Average_Body_Angular_Speed_Mean_Y_Axis**: Average body angular speed mean for Axis Y per subject and activity. Units: radians/second [rad/s]
24. **[Time]Average_Body_Angular_Speed_Mean_Z_Axis**: Average body angular speed mean for Axis Z per subject and activity. Units: radians/second [rad/s]
25. **[Time]Average_Body_Angular_Speed_StdDev_X_Axis**: Average body angular speed StdDev for Axis X per subject and activity. Units: radians/second [rad/s]
26. **[Time]Average_Body_Angular_Speed_StdDev_Y_Axis**: Average body angular speed StdDev for Axis Y per subject and activity. Units: radians/second [rad/s]
27. **[Time]Average_Body_Angular_Speed_StdDev_Z_Axis**: Average body angular speed StdDev for Axis Z per subject and activity. Units: radians/second [rad/s]
28. **[Time]Average_Body_Angular_Jerk_Mean_X_Axis**: Average body angular jerk mean for Axis X per subject and activity. Units: radians/second^3 [rad/s^3]
29. **[Time]Average_Body_Angular_Jerk_Mean_Y_Axis**: Average body angular jerk mean for Axis Y per subject and activity. Units: radians/second^3 [rad/s^3]
30. **[Time]Average_Body_Angular_Jerk_Mean_Z_Axis**: Average body angular jerk mean for Axis Z per subject and activity. Units: radians/second^3 [rad/s^3]
31. **[Time]Average_Body_Angular_Jerk_StdDev_X_Axis**: Average body angular jerk StdDev for Axis X per subject and activity. Units: radians/second^3 [rad/s^3]
32. **[Time]Average_Body_Angular_Jerk_StdDev_Y_Axis**: Average body angular jerk StdDev for Axis Y per subject and activity. Units: radians/second^3 [rad/s^3]
33. **[Time]Average_Body_Angular_Jerk_StdDev_Z_Axis**: Average body angular jerk StdDev for Axis Z per subject and activity. Units: radians/second^3 [rad/s^3]
34. **[Time]Average_Body_Acceleration_Magnitude_Mean**: Average body acceleration magnitude mean per subject and activity. Units: standard 'g' [m/s^2]
35. **[Time]Average_Body_Acceleration_Magnitude_StdDev**: Average body acceleration magnitude StdDev per subject and activity. Units: standard 'g' [m/s^2]
36. **[Time]Average_Gravity_Acceleration_Magnitude_Mean**: Average gravity acceleration magnitude mean per subject and activity. Units: standard 'g' [m/s^2]
37. **[Time]Average_Gravity_Acceleration_Magnitude_StdDev**: Average gravity acceleration magnitude StdDev per subject and activity. Units: standard 'g' [m/s^2]
38. **[Time]Average_Body_Linear_Jerk_Magnitude_Mean**: Average body linear jerk magnitude mean per subject and activity. Units: standard 'g/s' [m/s^3]
39. **[Time]Average_Body_Linear_Jerk_Magnitude_StdDev**: Average body linear jerk magnitude StdDev per subject and activity. Units: standard 'g/s' [m/s^3]
40. **[Time]Average_Body_Angular_Speed_Magnitude_Mean**: Average body angular speed magnitude mean per subject and activity. Units: radians/second [rad/s]
41. **[Time]Average_Body_Angular_Speed_Magnitude_StdDev**: Average body angular speed magnitude StdDev per subject and activity. Units: radians/second [rad/s]
42. **[Time]Average_Body_Angular_Jerk_Magnitude_Mean**: Average body angular jerk magnitude mean per subject and activity. Units: radians/second^3 [rad/s^3]
43. **[Time]Average_Body_Angular_Jerk_Magnitude_StdDev**: Average body angular jerk magnitude StdDev per subject and activity. Units: radians/second^3 [rad/s^3]
44. **[Freq]Average_Body_Acceleration_Mean_X_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration mean for Axis X per subject and activity. Units: standard 'g' [m/s^2]
45. **[Freq]Average_Body_Acceleration_Mean_Y_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration mean for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
46. **[Freq]Average_Body_Acceleration_Mean_Z_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration mean for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
47. **[Freq]Average_Body_Acceleration_StdDev_X_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration StdDev for Axis X per subject and activity. Units: standard 'g' [m/s^2]
48. **[Freq]Average_Body_Acceleration_StdDev_Y_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration StdDev for Axis Y per subject and activity. Units: standard 'g' [m/s^2]
49. **[Freq]Average_Body_Acceleration_StdDev_Z_Axis**: Average Fast Fourier Trasnform (FFT) body acceleration StdDev for Axis Z per subject and activity. Units: standard 'g' [m/s^2]
50. **[Freq]Average_Body_Acceleration_MeanFreq_X_Axis**: Average per subject and activity of Weighted average of the body acceleration frequency components to obtain a mean frequency in the X Axis. Units: Hz
51. **[Freq]Average_Body_Acceleration_MeanFreq_Y_Axis**: Average per subject and activity of the Weighted average of the body acceleration frequency components to obtain a mean frequency in the Y Axis. Units: Hz
52. **[Freq]Average_Body_Acceleration_MeanFreq_Z_Axis**: Average per subject and activity of the Weighted average of the body acceleration frequency components to obtain a mean frequency in the Z Axis. Units: Hz
53. **[Freq]Average_Body_Linear_Jerk_Mean_X_Axis**: Average FFT body linear jerk mean for Axis X per subject and activity. Units: ‘g/s’ [m/s^3]
54. **[Freq]Average_Body_Linear_Jerk_Mean_Y_Axis**: Average FFT body linear jerk mean for Axis Y per subject and activity. Units: ‘g/s’ [m/s^3]
55. **[Freq]Average_Body_Linear_Jerk_Mean_Z_Axis**: Average FFT body linear jerk mean for Axis Z per subject and activity. Units: ‘g/s’ [m/s^3]
56. **[Freq]Average_Body_Linear_Jerk_StdDev_X_Axis**: Average FFT body linear jerk StdDev for Axis X per subject and activity. Units: ‘g/s’ [m/s^3]
57. **[Freq]Average_Body_Linear_Jerk_StdDev_Y_Axis**: Average FFT body linear jerk StdDev for Axis Y per subject and activity. Units: ‘g/s’ [m/s^3]
58. **[Freq]Average_Body_Linear_Jerk_StdDev_Z_Axis**: Average FFT body linear jerk StdDev for Axis Z per subject and activity. Units: ‘g/s’ [m/s^3]
59. **[Freq]Average_Body_Linear_Jerk_MeanFreq_X_Axis**: Average per subject and activity of the Weighted average of the body linear jerk frequency components to obtain a mean frequency in the X Axis. Units: Hz
60. **[Freq]Average_Body_Linear_Jerk_MeanFreq_Y_Axis**: Average per subject and activity of the Weighted average of the body linear jerk frequency components to obtain a mean frequency in the Y Axis. Units: Hz
61. **[Freq]Average_Body_Linear_Jerk_MeanFreq_Z_Axis**: Average per subject and activity of the Weighted average of the body linear jerk frequency components to obtain a mean frequency in the Z Axis. Units: Hz
62. **[Freq]Average_Body_Angular_Speed_Mean_X_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed mean for Axis X per subject and activity. Units: radians/second [rad/s]
63. **[Freq]Average_Body_Angular_Speed_Mean_Y_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed mean for Axis Y per subject and activity. Units: radians/second [rad/s]
64. **[Freq]Average_Body_Angular_Speed_Mean_Z_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed mean for Axis Z per subject and activity. Units: radians/second [rad/s]
65. **[Freq]Average_Body_Angular_Speed_StdDev_X_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed StdDev for Axis X per subject and activity. Units: radians/second [rad/s]
66. **[Freq]Average_Body_Angular_Speed_StdDev_Y_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed StdDev for Axis Y per subject and activity. Units: radians/second [rad/s]
67. **[Freq]Average_Body_Angular_Speed_StdDev_Z_Axis**: Average Fast Fourier Trasnform (FFT) body angular speed StdDev for Axis Z per subject and activity. Units: radians/second [rad/s]
68. **[Freq]Average_Body_Angular_Speed_MeanFreq_X_Axis**: Average per subject and activity of Weighted average of the body angular speed frequency components to obtain a mean frequency in the X Axis. Units: Hz
69. **[Freq]Average_Body_Angular_Speed_MeanFreq_Y_Axis**: Average per subject and activity of Weighted average of the body angular speed frequency components to obtain a mean frequency in the Y Axis. Units: Hz
70. **[Freq]Average_Body_Angular_Speed_MeanFreq_Z_Axis**: Average per subject and activity of Weighted average of the body angular speed frequency components to obtain a mean frequency in the Z Axis. Units: Hz
71. **[Freq]Average_Body_Acceleration_Magnitude_Mean**: Average per subject and activity of FFT of Body Acceleration Magnitude Mean. Units: standard 'g' [m/s^2]
72. **[Freq]Average_Body_Acceleration_Magnitude_StdDev**: Average per subject and activity of FFT of Body Acceleration Magnitude StdDev. Units: standard 'g' [m/s^2]
73. **[Freq]Average_Body_Acceleration_Magnitude_MeanFreq**: Average per subject and activity of weighted average of body acceleration magnitude frequency components to obtain a mean frequency. Units: Hz
74. **[Freq]Average_Body_Linear_Jerk_Magnitude_Mean**: Average FFT body linear jerk margnitude mean per subject and activity. Units: standard 'g' [m/s^2]
75. **[Freq]Average_Body_Linear_Jerk_Magnitude_StdDev**: Average FFT body linear jerk magnitude StdDev per subject and activity. Units: standard 'g' [m/s^2]
76. **[Freq]Average_Body_Linear_Jerk_Magnitude_MeanFreq**: Average per subject and activity of weighted average of linear jerk magnitude frequency components to obtain a mean frequency. Units: Hz
77. **[Freq]Average_Body_Angular_Speed_Magnitude_Mean**: Average FFT body angular speed magnitude mean per subject and activity. Units: radians/second [rad/s]
78. **[Freq]Average_Body_Angular_Speed_Magnitude_StdDev**Average FFT body angular speed magnitude StdDev per subject and activity. Units: radians/second [rad/s]
79. **[Freq]Average_Body_Angular_Speed_Magnitude_MeanFreq**: Average per subject and activity of weighted average of angular speed magnitude frequency components to obtain a mean frequency. Units: Hz
80. **[Freq]Average_Body_Angular_Jerk_Magnitude_Mean**: Average FFT body angular jerk mean magnitude per subject and activity. Units: radians/second^3 [rad/s^3]
81. **[Freq]Average_Body_Angular_Jerk_Magnitude_StdDev**: Average FFT body angular jerk StdDev magnitude per subject and activity. Units: radians/second^3 [rad/s^3]
82. **[Freq]Average_Body_Angular_Jerk_Magnitude_MeanFreq**: Average per subject and activity of weighted average of angular jerk magnitude frequency components to obtain a mean frequency. Units: Hz
