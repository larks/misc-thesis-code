/*
** Simple program that makes it easier to read the rorc_receive text file outputs.
** Simply compile: gcc frasier.c -o frasier
** Then run it like: ./frasier input.txt >> output.txt
** lbratrud 2013
*/

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void decodeTrailer(int, unsigned int);
void decodeHeader(int, unsigned int);

	int blockCnt = 0;
	int eventCnt = 0;

int main( int argc, char *argv[] )
{
	if(argc < 2){
		printf("Needs filename argument (e.g. ./frasier data.txt) \n");
		exit(EXIT_FAILURE);
	}
	FILE * fIn;
	//FILE * fOut;
	//fopen("outputdeath.txt", "w"); // delete existing output file
	char filename[100];
	strcpy(filename, argv[1]);
	char * line = NULL;
	unsigned int hex = 0;
	int cdhLine = 0;
	int trailLine = 0;

	int cntDW = 0;
	size_t len = 0;
	size_t read;
	char test[10] = "0xdeadbeef";

	fIn = fopen(filename, "r");
	if (fIn == NULL) exit(EXIT_FAILURE);
	// Read file line by line
	while ((read = getline(&line, &len, fIn)) != -1) {
		// Only care about the 32 bit hexadecimals
		if(read == 11){ 
			hex = strtoul(line, NULL, 0); // convert so we can do some bit magic
				// Header
				if(cdhLine <= 7){
					if(hex == 0xffffffff){
					   cdhLine = 0;
					   printf("NEW BLOCK... \n");
					   //printf("CDH%d: 0x%x \n", cdhLine, hex);
					   decodeHeader(cdhLine, hex);
					   cdhLine++;
					}
					else{
					printf("");
					//printf("CDH%d: 0x%x \n", cdhLine, hex);
					decodeHeader(cdhLine, hex);
					cdhLine++;
					}
				}
				else //if (cdhLine >= 7)
					// check for channel header
					if((hex & 0x40000000) && !(hex & 0x80000000)){
						printf("nr. datawords: %d \n", cntDW); cntDW = 0;
						printf("channel header:  ");
						printf("%x \n", hex);
						printf("Channel address from ALTRO: %x -- FEC%d A%d CH%d \n", hex&0xFFF, (hex&0x780)>>7, (hex&0x70)>>4, hex & 0xF );
						printf("Block length number of 10 bit words from ALTRO (dec): %d \n", (hex & 0x3FFF000)>>12);
						printf("Channel error bit: %x \n\n", (hex & 0x20000000) >> 30);
			  	   }
			  	   // check for trailer ID
			  	   else if (hex & 0x80000000){
			  	      if(hex & 0x40000000){ 
			  	      	printf("END OF RCU TRAILER %d: 0x%x:::", trailLine, hex); 
			  	      	printf("RCU ID     0x%x \n\n\n", (hex & 0x3FFFFFF));
			  	      	//blockCnt++; 
			  	      	cdhLine = 0; 
			  	      	trailLine = 0; 
			  	      }
			  	      else{
			  	      //printf("RCU Trailer %d: %x \n", trailLine, hex);
			  	      printf("RCU Trailer %d: 0x%x:::", trailLine, hex);
						decodeTrailer(trailLine, hex);
			  	      	
			  	      	
			  	      trailLine++;
			  	      }
			  	   }
				   else
				   // DW
					printf("%x, %x, %x \n", (hex&0x3ff00000)>>20, (hex&0x000FFC00)>>10, hex&0x3FF);
					cntDW=cntDW+3;
					//fOut = fopen("outputdeath.txt", "a");
					//if(fOut == NULL) exit(EXIT_FAILURE);
					//fprintf(fOut, "%x\n%x\n%x\n", (hex&0x3ff00000)>>20, (hex&0x000FFC00)>>10, hex&0x3FF);
					/*
					Extract each data word, put in a file, each dw separated by a newline......
					*/
		}
		else{
			if(strstr(line, "# Event")) eventCnt++;
			if(strstr(line, "# Block")) blockCnt++;
		}
	}
	if (line) free(line);
	printf("Number of events: %d \n", eventCnt);
	printf("Number of blocks: %d \n", blockCnt);
	fclose(fIn); //fclose(fOut);
	exit(EXIT_SUCCESS);
}
/* Take a look at trailer */
void decodeTrailer(int n, unsigned int hex)
{
	switch(n){
		case 0: printf("Payload Length:   %d \n",   (hex & 0x3FFFFFF)); break;
		case 1: printf("Error register 1: 0x%x \n", (hex & 0x3FFFFFF)); break;
		case 2: printf("Error register 2: 0x%x \n", (hex & 0x3FFFFFF)); break;
		case 3: printf("Error register 3: 0x%x \n", (hex & 0x3FFFFFF)); break;
		case 4: printf("Act FEC A:        0x%x \n", (hex & 0x3FFFFFF)); break;
		case 5: printf("Act FEC B         0x%x \n", (hex & 0x3FFFFFF)); break;
		case 6: printf("RDO CONFIG 1      0x%x \n", (hex & 0x3FFFFFF)); break;
		case 7: printf("RDO CONFIG 2      0x%x \n", (hex & 0x3FFFFFF)); break;
		case 8: printf("RCU ID     0x%x \n", (hex & 0x3FFFFFF)); break;		  	      	
	}
}
/* Take a look at Common Data Header */
void decodeHeader(int n, unsigned int hex)
{
	switch(n){
		case 0: printf("Block length:                0x%x \n", hex); 
		        break;
		case 1: printf("Format version:              0x%x\n", (hex&0xFF000000)>>24 );
		        printf("L1 trig. msg:                0x%x\n", (hex&0x3FC000)>>14   );
		        printf("Event ID 1 (bunch crossing): 0x%x\n", (hex&0xFFF)          );
		        break;
		case 2: printf("Event ID 2 (orbit number):   0x%x\n", (hex&0xFFFFFF)       ); 
		        break;
		case 3: printf("RCU Version:                 0x%x\n", (hex&0xFF000000)>>24 );
		        printf("Participating sub-detectors: 0x%x\n", (hex&0xFFFFFF)       );
		        break;
		case 4: printf("Status & error bits:         0x%x\n", (hex&0xFFFF000)>>12  );
		        printf("Mini-event ID (bc):          0x%x\n", (hex&0xFFF)          );
		        break;
		case 5: printf("Trigger classes low:         0x%x\n", hex                  ); 
		        break;
		case 6: printf("ROI low:                     0x%x\n", (hex&0xFF000000)>>24 );
		        printf("Trigger classes high:        0x%x\n", hex&0x3FFFF         ); 
		        break;
		case 7: printf("ROI high:                    0x%x \n", hex                 ); 
		        break;
	}
}
