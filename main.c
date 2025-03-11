// Author: Chandresh chavda
// Author email: chav349@csu.fullerton.edu
// CWID: 885158899
// Class: 240-11 Section 11
// Date: March 11, 2025


#include <stdio.h>
// #include <math.h>
#include <string.h>
#include <stdlib.h>

// Declaration of external function that calculates electricity
extern double electricity();

int main(void)
{
    // Display program information and author's details to the user
    printf("\nWelcome to West Beach Electric Company.\n");
    printf("This software is maintained by Chandresh Chavda.\n\n");
 
    // Call the electricity function to compute the required value
    double count = 0;
    count = electricity();
 
    // Output the result and inform the user of the final outcome before exiting
    printf("\nThe main program received the value %.5lf and will keep it for later.\n", count);
    printf("A zero will be returned to the operating system. Bye.\n");
}
