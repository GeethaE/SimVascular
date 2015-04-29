/*=========================================================================
 *
 * Copyright (c) 2014-2015 The Regents of the University of California.
 * All Rights Reserved.
 *
 * Portions of the code Copyright (c) 2009-2011 Open Source Medical
 * Software Corporation, University of California, San Diego.
 *
 * Portions of the code Copyright (c) 1998-2007 Stanford University, 
 * Rensselaer Polytechnic Institute, Charles A. Taylor, 
 * Kenneth E. Jansen.
 * 
 * See SimVascular Acknowledgements file for additional
 * contributors to the source code. 
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions 
 * are met:

 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer. 
 * Redistributions in binary form must reproduce the above copyright 
 * notice, this list of conditions and the following disclaimer in the 
 * documentation and/or other materials provided with the distribution. 
 * Neither the name of the Stanford University or Rensselaer Polytechnic
 * Institute nor the names of its contributors may be used to endorse or
 * promote products derived from this software without specific prior 
 * written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
 * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

/* This file provides interface functions for 'partial ' random 
   access into the input files */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>
#include "mpi.h"
#include "cvSolverIO.h"
#include "cvFlowsolverOptions.h"

#ifdef WIN32
#include <winsock2.h>
#else
#include <unistd.h>
#include <strings.h>
#endif

#ifdef CV_WRAP_FORTRAN_IN_CAPS_NO_UNDERSCORE
  #define Write_Restart WRITE_RESTART
  #define Write_Error   WRITE_ERROR
  #define Write_Displ   WRITE_DISPL
#endif

#ifdef CV_WRAP_FORTRAN_LOWERCASE_WITH_UNDERSCORE
  #define Write_Restart write_restart_
  #define Write_Error   write_error_
  #define Write_Displ   write_displ_
#endif

extern char cvsolver_iotype[80];

void 
Write_Restart(  int* pid, 
                int* stepno, 
                int* nshg, 
                int* numVars,
                double* array1, 
                double* array2 ) {

    char fname[255];
    char rfile[60];
    char existingfile[30], linkfile[30];
    int irstou;
    int magic_number = 362436;
    int* mptr = &magic_number;
    time_t timenow = time ( &timenow);
    double version=0.0;
    int isize, nitems;
    int iarray[10];

    sprintf(rfile,"restart.%d.%d",*stepno,*pid+1);
    if (openfile_(rfile,"write", &irstou) == CVSOLVER_IO_ERROR) {
      fprintf(stderr,"IO_ERROR opening file [%s] in Write_Restart.\n",rfile);
      return;
    }

    /* writing the top ascii header for the restart file */

    writestring_( &irstou,"# SimVascular Input File Version 2.0\n");
    writestring_( &irstou,
                  "# format \"keyphrase : sizeofnextblock usual headers\"\n");

    bzero( (void*)fname, 255 );
    sprintf(fname,"# Output Generated by SimVascular Version: %s \n", SIMVASCULAR_FULL_VER_NO);
    writestring_( &irstou, fname );

    bzero( (void*)fname, 255 );
    gethostname(fname,255);
    writestring_( &irstou,"# This result was produced on: ");
    writestring_( &irstou, fname );
    writestring_( &irstou,"\n");

    bzero( (void*)fname, 255 );
    sprintf(fname,"# %s\n", ctime( &timenow ));
    writestring_( &irstou, fname );

    isize = 1;
    nitems = 1;
    iarray[ 0 ] = 1;
    writeheader_( &irstou, "byteorder magic number ", 
                  (void*)iarray, &nitems, &isize, "integer", cvsolver_iotype );
    
    nitems = 1;
    writedatablock_( &irstou, "byteorder magic number ",
                     (void*)mptr, &nitems, "integer", cvsolver_iotype );
    
    
    bzero( (void*)fname, 255 );
    sprintf(fname,"number of modes : < 0 > %d\n", *nshg);
    writestring_( &irstou, fname );
    
    bzero( (void*)fname, 255 );
    sprintf(fname,"number of variables : < 0 > %d\n", *numVars);
    writestring_( &irstou, fname );
        
    
    isize = (*nshg)*(*numVars);
    nitems = 3;
    iarray[ 0 ] = (*nshg);
    iarray[ 1 ] = (*numVars);
    iarray[ 2 ] = (*stepno);
    writeheader_( &irstou, "solution ", 
                  (void*)iarray, &nitems, &isize, "double", cvsolver_iotype );
    
        
    nitems = (*nshg)*(*numVars);
    writedatablock_( &irstou, "solution ",
                     (void*)(array1), &nitems, "double", cvsolver_iotype );
        
   

    nitems = 3;
    writeheader_( &irstou, "time derivative of solution ", 
                  (void*)iarray, &nitems, &isize, "double", cvsolver_iotype );
    
    
    nitems = (*nshg)*(*numVars);
    writedatablock_( &irstou, "time derivative of solution ",
                     (void*)(array2), &nitems, "double", cvsolver_iotype );

        
    closefile_( &irstou, "write" );
      
    MPI_Barrier(MPI_COMM_WORLD);

    /* create a soft link of the restart we just wrote to restart.latest
     this is the file the next run will always try to start from */

    //sprintf( linkfile, "restart.latest.%d", *pid+1 );
    //unlink( linkfile );
    //sprintf( existingfile, "restart.%d.%d", *stepno, *pid+1 );
    //link( existingfile, linkfile );
}

void 
Write_Error(  int* pid, 
              int* stepno, 
              int* nshg, 
              int* numVars,
              double* array1 ) { 


    char fname[255];
    char rfile[60];
    int irstou;
    int magic_number = 362436;
    int* mptr = &magic_number;
    time_t timenow = time ( &timenow);
    double version=0.0;
    int isize, nitems;
    int iarray[10];

    sprintf(rfile,"restart.%d.%d",*stepno,*pid+1);
    if (openfile_(rfile,"append", &irstou) == CVSOLVER_IO_ERROR) {
      fprintf(stderr,"IO_ERROR opening file [%s] in Write_Restart.\n",rfile);
      return;
    }

    isize = (*nshg)*(*numVars);
    nitems = 3;
    iarray[ 0 ] = (*nshg);
    iarray[ 1 ] = (*numVars);
    iarray[ 2 ] = (*stepno);
    writeheader_( &irstou, "errors", (void*)iarray, &nitems, &isize, "double", cvsolver_iotype );
    
        
    nitems = (*nshg)*(*numVars);
    writedatablock_( &irstou, "errors ", (void*)(array1), &nitems, "double", cvsolver_iotype );

    closefile_( &irstou, "append" );
    
}


void 
Write_Displ(  int* pid, 
              int* stepno, 
              int* nshg, 
              int* numVars,
              double* array1,
			  int* flag) {


    char fname[255];
    char rfile[60];
    int irstou;
    int magic_number = 362436;
    int* mptr = &magic_number;
    time_t timenow = time ( &timenow);
    double version=0.0;
    int isize, nitems;
    int iarray[10];
    int i,j;

    sprintf(rfile,"restart.%d.%d",*stepno,*pid+1);
    if (openfile_(rfile,"append", &irstou) == CVSOLVER_IO_ERROR) {
      fprintf(stderr,"IO_ERROR opening file [%s] in Write_Restart.\n",rfile);
      return;
    }

    //set displacement as zero for any other nodes than on the deformable wall
    for(i = 0; i< *nshg; i++){
      for(j=0; j< *numVars; j++){
    	  if(flag[i]==0){
            array1[j*(*nshg)+i]=0.0;
    	  }
      }
    }

    isize = (*nshg)*(*numVars);
    nitems = 3;
    iarray[ 0 ] = (*nshg);
    iarray[ 1 ] = (*numVars);
    iarray[ 2 ] = (*stepno);
    writeheader_( &irstou, "displacement", (void*)iarray, &nitems, &isize, "double", cvsolver_iotype );
    
        
    nitems = (*nshg)*(*numVars);
    writedatablock_( &irstou, "displacement", (void*)(array1), &nitems, "double", cvsolver_iotype );

    closefile_( &irstou, "append" );
    
}



