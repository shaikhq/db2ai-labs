static char sqla_program_id[292] = 
{
 '\xac','\x0','\x41','\x45','\x41','\x56','\x41','\x49','\x65','\x42','\x78','\x41','\x50','\x50','\x43','\x70','\x30','\x31','\x31','\x31',
 '\x31','\x20','\x32','\x20','\x20','\x20','\x20','\x20','\x20','\x20','\x20','\x20','\x8','\x0','\x44','\x42','\x32','\x49','\x4e','\x53',
 '\x54','\x31','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x8','\x0','\x53','\x49','\x4d','\x49','\x4c','\x41','\x52','\x49','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0',
 '\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0','\x0'
};

#include "sqladef.h"

static struct sqla_runtime_info sqla_rtinfo = 
{{'S','Q','L','A','R','T','I','N'}, sizeof(wchar_t), 0, {' ',' ',' ',' '}};


static const short sqlIsLiteral   = SQL_IS_LITERAL;
static const short sqlIsInputHvar = SQL_IS_INPUT_HVAR;


#line 1 "similarityudf.sqc"
/****************************************************************************
** (c) Copyright IBM Corp. 2007 All rights reserved.
** 
** The following sample of source code ("Sample") is owned by International 
** Business Machines Corporation or one of its subsidiaries ("IBM") and is 
** copyrighted and licensed, not sold. You may use, copy, modify, and 
** distribute the Sample in any form without payment to IBM, for the purpose of 
** assisting you in the development of your applications.
** 
** The Sample code is provided to you on an "AS IS" basis, without warranty of 
** any kind. IBM HEREBY EXPRESSLY DISCLAIMS ALL WARRANTIES, EITHER EXPRESS OR 
** IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
** MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. Some jurisdictions do 
** not allow for the exclusion or limitation of implied warranties, so the above 
** limitations or exclusions may not apply to you. IBM shall not be liable for 
** any damages you suffer as a result of using, copying, modifying or 
** distributing the Sample, even if IBM has been advised of the possibility of 
** such damages.
*****************************************************************************
**
** SOURCE FILE NAME: udfemsrv.sqc
**
** SAMPLE: Call a variety of types of embedded SQL user-defined functions.
**
**         This file contains the user defined functions called by
**         udfemcli.
**
** SQL STATEMENTS USED:
**         BEGIN DECLARE SECTION
**         END DECLARE SECTION
**         PREPARE
**         DECLARE CURSOR
**         OPEN
**         FETCH
**         CLOSE
**         SELECT
**
** OUTPUT FILE: udfemcli.out (available in the online documentation)
*****************************************************************************
**
** For more information on the sample programs, see the README file.
**
** For information on developing C applications, see the Application
** Development Guide.
**
** For information on using SQL statements, see the SQL Reference.
**
** For information on DB2 APIs, see the Administrative API Reference.
**
** For the latest information on programming, building, and running DB2
** applications, visit the DB2 application development website:
**     http://www.software.ibm.com/data/db2/udb/ad
****************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sqludf.h>
#include <sqlca.h>
#include <sqlenv.h>
#include <math.h>
#include <stddef.h>

#if(defined(DB2NT))
#define PATH_SEP "\\"
#else /* UNIX */
#define PATH_SEP "/"
#endif

float dotProduct(float* a, float* b, int size) {
    float sum = 0;
    int i;
    for(i = 0; i < size; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}

float magnitude(float* a, int size) {
    float sum = 0;
    int i;
    for(i = 0; i < size; i++) {
        sum += a[i] * a[i];
    }
    return sqrt(sum);
}

float cosineDistance(float* a, float* b, int size) {
    float dot = dotProduct(a, b, size);
    float magA = magnitude(a, size);
    float magB = magnitude(b, size);
    return dot / (magA * magB);
}


/* This UDF returns the cosien distance between two vectors. */
#ifdef __cplusplus
extern "C"
#endif
void SQL_API_FN VECTOR_DISTANCE(SQLUDF_VARBINARY  *inVecInput1,
                            SQLUDF_VARBINARY  *inVecInput2,
                            SQLUDF_REAL *outFloat,
                            SQLUDF_NULLIND *vecInput1NullInd,
                            SQLUDF_NULLIND *vecInput2NullInd,
                            SQLUDF_NULLIND *outFloatNullInd,
                            SQLUDF_TRAIL_ARGS)
{
  
  size_t length_of_vector = inVecInput1->length / sizeof(float);

  // allocate memory for a float point array to hold the input vector
  float* array1 = (float*)malloc(length_of_vector * sizeof(float));
  memcpy(array1, inVecInput1->data, inVecInput1->length);

  // allocate memory for a floating point array to hold the input vector
  float* array2 = (float*)malloc(length_of_vector * sizeof(float));
  memcpy(array2, inVecInput2->data, inVecInput2->length);


  *outFloat = cosineDistance(array1, array2, length_of_vector);
  
 exit:
  return;
}

#ifdef __cplusplus
extern "C"
#endif
void SQL_API_FN CHAR_TO_VEC(SQLUDF_VARCHAR *inInputVec,
                       SQLUDF_VARBINARY *outOutputVec,
                       SQLUDF_NULLIND *inputVecNullInd,
                       SQLUDF_NULLIND *outputVecNullInd,
                       SQLUDF_TRAIL_ARGS)
{
  // First pass: count the number of floats in the input string
  int vec_length = 0;
  char *inputCopy = strdup(inInputVec + 1); // Skip the opening bracket
  inputCopy[strlen(inputCopy) - 1] = '\0'; // Remove the closing bracket
  char *token = strtok(inputCopy, ", ");
  while (token != NULL) {
    vec_length++;
    token = strtok(NULL, ", ");
  }
  free(inputCopy);

  // Allocate memory for the arrays
  float *vec = (float *)malloc(vec_length * sizeof(float));
  unsigned char *bytes = (unsigned char *)malloc(vec_length * sizeof(float));

  // Second pass: parse the floats and convert them to bytes
  int i = 0;
  char *inputCopy2 = strdup(inInputVec + 1); // Skip the opening bracket
  inputCopy2[strlen(inputCopy2) - 1] = '\0'; // Remove the closing bracket
  token = strtok(inputCopy2, ", ");
  while (token != NULL) {
    float value = atof(token);
    vec[i] = value;
    memcpy(bytes + i * sizeof(float), &value, sizeof(float));
    i++;
    token = strtok(NULL, ", ");
  }
  free(inputCopy2);

  // Copy the bytes to the output vector
  memcpy(outOutputVec->data, bytes, vec_length * sizeof(float));
  outOutputVec->length = vec_length * sizeof(float);

  // Set the null indicator for the output string to not null
  *outputVecNullInd = 0;

  // Free the allocated memory
  free(vec);
  free(bytes);

  exit:
    return;
}


#ifdef __cplusplus
extern "C"
#endif
void SQL_API_FN VECTOR_LEN(SQLUDF_VARBINARY  *inVec,
                            SQLUDF_SMALLINT *outLen,
                            SQLUDF_NULLIND *vecNullInd,
                            SQLUDF_NULLIND *lenNullInd,
                            SQLUDF_TRAIL_ARGS)
{
  struct {
  sqluint16 length;
  char data[6144];  // Increase the size to accommodate larger vectors
  } myVec;

  memcpy(myVec.data, inVec->data, inVec->length);  // Use memcpy instead of strcpy for binary data
  myVec.length = inVec->length;

  size_t length_of_vector = myVec.length / sizeof(float);  // Use sizeof(float) instead of sizeof(int)
  *outLen = (SQLUDF_SMALLINT) (length_of_vector);

  return;
}


#ifdef __cplusplus
extern "C"
#endif
void SQL_API_FN VEC_TO_CHAR(SQLUDF_VARBINARY  *inVec,
                                  SQLUDF_VARCHAR *outStr,
                                  SQLUDF_NULLIND *vecNullInd,
                                  SQLUDF_NULLIND *strNullInd,
                                  SQLUDF_TRAIL_ARGS)
{
    struct {
        sqluint16 length;
        char data[6144];
    } myVec;

    strcpy(myVec.data, inVec->data);
    myVec.length = inVec->length;

    size_t length_of_array = myVec.length / sizeof(float);

    float* array = (float*)malloc(length_of_array * sizeof(float));
    memcpy(array, inVec->data, inVec->length);

    char* string = (char*)malloc(length_of_array * 50 * sizeof(char)); // Increased size for float representation

    // Start the string with an opening bracket
    strcpy(string, "[");

    // Format each float as a string and concatenate
    int i;
    for (i = 0; i < length_of_array; ++i) {
        char buffer[50]; // Increased size for float representation
        sprintf(buffer, "%g, ", array[i]); // Use %g to format as float with original precision
        strcat(string, buffer);
    }

    // Remove the trailing comma and space, and add a closing bracket
    if (length_of_array > 0) {
        string[strlen(string) - 2] = ']';
        string[strlen(string) - 1] = '\0';
    } else {
        strcat(string, "]");
    }

    // Copy the string to the output parameter
    strcpy(outStr, string);

    // Set the null indicator for the output string to not null
    *strNullInd = 0;

    // Free the allocated memory
    free(array);
    free(string);

    exit:
    return;
}