/*
 Adobe Systems Incorporated(r) Source Code License Agreement
 Copyright(c) 2006 Adobe Systems Incorporated. All rights reserved.
 
 Please read this Source Code License Agreement carefully before using
 the source code.
 
 Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive,
 no-charge, royalty-free, irrevocable copyright license, to reproduce,
 prepare derivative works of, publicly display, publicly perform, and
 distribute this source code and such derivative works in source or
 object code form without any attribution requirements.
 
 The name "Adobe Systems Incorporated" must not be used to endorse or promote products
 derived from the source code without prior written permission.
 
 You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
 against any loss, damage, claims or lawsuits, including attorney's
 fees that arise or result from your use or distribution of the source
 code.
 
 THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT
 ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
 BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE ARE DISCLAIMED. ALSO, THERE IS NO WARRANTY OF
 NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT. IN NO EVENT SHALL MACROMEDIA
 OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <strings.h>
#include <cstdlib>

enum {
	pbjNop					= 0x00,
	pbjAdd					= 0x01,
	pbjSubtract				= 0x02,
	pbjMultiply				= 0x03,
	pbjReciprocal			= 0x04,
	pbjDivide				= 0x05,
	pbjAtan2				= 0x06,
	pbjPow					= 0x07,
	pbjMod					= 0x08,
	pbjMin					= 0x09,
	pbjMax					= 0x0A,
	pbjStep					= 0x0B,
	pbjSin					= 0x0C,
	pbjCos					= 0x0D,
	pbjTan					= 0x0E,
	pbjASin					= 0x0F,
	pbjACos					= 0x10,
	pbjATan					= 0x11,
	pbjExp					= 0x12,
	pbjExp2					= 0x13,
	pbjLog					= 0x14,
	pbjLog2					= 0x15,
	pbjSqrt					= 0x16,
	pbjRSqrt				= 0x17,
	pbjAbs					= 0x18,
	pbjSign					= 0x19,
	pbjFloor				= 0x1A,
	pbjCeil					= 0x1B,
	pbjFract				= 0x1C,
	pbjCopy					= 0x1D,
	pbjFloatToInt			= 0x1E,
	pbjIntToFloat			= 0x1F,
	pbjMatrixMatrixMultiply	= 0x20,
	pbjVectorMatrixMultiply	= 0x21,
	pbjMatrixVectorMultiply	= 0x22,
	pbjNormalize			= 0x23,
	pbjLength				= 0x24,
	pbjDistance				= 0x25,
	pbjDotProduct			= 0x26,
	pbjCrossProduct			= 0x27,
	pbjEqual				= 0x28,
	pbjNotEqual				= 0x29,
	pbjLessThan				= 0x2A,
	pbjLessThanEqual		= 0x2B,
	pbjLogicalNot			= 0x2C,
	pbjLogicalAnd			= 0x2D,
	pbjLogicalOr			= 0x2E,
	pbjLogicalXor			= 0x2F,
	pbjSampleNearest		= 0x30,
	pbjSampleBilinear		= 0x31,
	pbjLoadConstant			= 0x32,
	pbjSelect				= 0x33,
	pbjIf					= 0x34,
	pbjElse					= 0x35,
	pbjEndif				= 0x36,
	pbjFloatToBool			= 0x37,
	pbjBoolToFloat			= 0x38,
	pbjIntToBool			= 0x39,
	pbjBoolToInt			= 0x3A,
	pbjVectorEqual			= 0x3B,
	pbjVectorNotEqual		= 0x3C,
	pbjAny					= 0x3D,
	pbjAll					= 0x3E,
	pbjKernelMetaData		= 0xa0,
	pbjParameterData		= 0xa1,
	pbjParameterMetaData	= 0xa2,
	pbjTextureData			= 0xa3,
	pbjKernelName			= 0xa4,
	pbjVersionData			= 0xa5,
	
	pbjTypeFloat			= 0x01,
	pbjTypeFloat2			= 0x02,
	pbjTypeFloat3			= 0x03,
	pbjTypeFloat4			= 0x04,
	pbjTypeFloat2x2			= 0x05,
	pbjTypeFloat3x3			= 0x06,
	pbjTypeFloat4x4			= 0x07,
	pbjTypeInt				= 0x08,
	pbjTypeInt2				= 0x09,
	pbjTypeInt3				= 0x0A,
	pbjTypeInt4				= 0x0B,
	pbjTypeString			= 0x0C,
	pbjTypeBool				= 0x0D,
	pbjTypeBool2			= 0x0E,
	pbjTypeBool3			= 0x0F,
	pbjTypeBool4			= 0x10,
	
	pbjSampleSizeScalar		= 0x01,
	pbjSampleSizeVector2	= 0x02,
	pbjSampleSizeVector3	= 0x03,
	pbjSampleSizeVector4	= 0x04,
};

static FILE *ifile = 0;
static FILE *ofile = 0;

const char *opNamesLo[] = {
"nop", 
"add", 
"sub", 
"mul", 
"rcp", 
"div", 
"atan2", 
"pow", 
"mod", 
"min", 
"max", 
"step", 
"sin", 
"cos", 
"tan", 
"asin", 
"acos", 
"atan", 
"exp", 
"exp2", 
"log", 
"log2", 
"sqr", 
"rsqr", 
"abs", 
"sign", 
"floor", 
"ceil", 
"fract", 
"mov", 
"ftoi", 
"itof", 
"mmmul", 
"vmmul", 
"mvmul", 
"norm", 
"len", 
"dist", 
"dot", 
"cross", 
"equ", 
"neq", 
"ltn", 
"lte", 
"not", 
"and", 
"or", 
"xor", 
"texn", 
"texb", 
"set", 
"sel", 
"if", 
"else", 
"end", 
"ftob", 
"btof", 
"itob", 
"btoi", 
"vequ", 
"vneq",  
"any", 
"all", 
};

const char *opNamesHi[] = {
"kernel",
"parameter",
"meta",
"texture",
"name",
"version",
};

const char *matrixNames[] = {
"",
"2x2",
"3x3",
"4x4",
};

const int32_t typeSizes[] = {
0,
1,
2,
3,
4,
4,
9,
16,
1,
2,
3,
4,
0,
1,
2,
3,
4,
};

const char *typeNames[] = {
"",
"float",
"float2",
"float3",
"float4",
"matrix2x2",
"matrix3x3",
"matrix4x4",
"int",
"int2",
"int3",
"int4",
"bool",
"bool2",
"bool3",
"bool4",
};

const char *qualifierName[] = {
"",
"in",
"out",
};

bool available()
{
	return feof(ifile)==0;
}

uint32_t readUint32()
{
	uint8_t c0 = (uint8_t)fgetc(ifile);
	uint8_t c1 = (uint8_t)fgetc(ifile);
	uint8_t c2 = (uint8_t)fgetc(ifile);
	uint8_t c3 = (uint8_t)fgetc(ifile);
	return (c0<<24)|(c1<<16)|(c2<<8)|(c3<<0);
}

uint16_t readUint16()
{
	uint8_t c0 = (uint8_t)fgetc(ifile);
	uint8_t c1 = (uint8_t)fgetc(ifile);
	return (c0<<8)|(c1);
}

uint8_t readUint8()
{
	uint8_t c0 = (uint8_t)fgetc(ifile);
	return c0;
}

float readFloat()
{
	union {
		uint32_t i;
		float    f;
	};
	i = (((uint32_t)((uint8_t)fgetc(ifile)))<<24)|
	(((uint32_t)((uint8_t)fgetc(ifile)))<<16)|
	(((uint32_t)((uint8_t)fgetc(ifile)))<< 8)|
	(((uint32_t)((uint8_t)fgetc(ifile)))<< 0);
	return f;
}

const char *readStrN(int32_t size)
{
	char *str = (char *)malloc(size+1);
	fread(str,size,1,ifile);
	str[size] = 0;
	return str;
}

const char *readStr()
{
	int32_t pos = (int32_t)ftell(ifile);
	int32_t c=0;
	for ( ; ; c++ ) {
		if ( !available() ) {
			return 0;
		}
		if ( readUint8() == 0 ) {
			break;
		}
	}
	fseek(ifile,pos,SEEK_SET);
	return readStrN(c+1);
}

void seek(int32_t pos)
{
	fseek(ifile,pos,SEEK_CUR);
}

inline bool isIntReg(int32_t reg)
{ 
	return (reg&0x8000)?true:false; 
}

inline uint16_t littleToBig16(uint16_t v ) {
	return ((v>>8)&0xFF)|((v<<8)&0xFF00);
}

inline int32_t Swizzle(int32_t index, int32_t swizzle) {
	return (swizzle>>(6-index*2))&3;
}

int32_t BitCount(uint32_t n)                          
{
	uint32_t tmp = n - ((n >> 1) & 033333333333) - ((n >> 2) & 011111111111);
	return ((tmp + (tmp >> 3)) & 030707070707) % 63;
}

int32_t IndexToDstWithMask(int32_t index, int32_t mask) 
{
	static const int32_t map[4*16] = {
		0x00,0x00,0x00,0x00,
		0x03,0x00,0x00,0x00,
		0x02,0x00,0x00,0x00,
		0x02,0x03,0x00,0x00,
		0x01,0x00,0x00,0x00,
		0x01,0x03,0x00,0x00,
		0x01,0x02,0x00,0x00,
		0x01,0x02,0x03,0x00,
		0x00,0x00,0x00,0x00,
		0x00,0x03,0x00,0x00,
		0x00,0x02,0x00,0x00,
		0x00,0x02,0x03,0x00,
		0x00,0x01,0x00,0x00,
		0x00,0x01,0x03,0x00,
		0x00,0x01,0x02,0x00,
		0x00,0x01,0x02,0x03
	};
	return map[(mask<<2|index)];
}

void printWriteMask(int32_t writeMask, int32_t type)
{
	if ( writeMask != 0xF ) {
		fprintf(ofile,".");
		const char cnam[4] = { 'r','g','b','a' };
		for ( int c=0; c<typeSizes[type]; c++ ) {
			fprintf(ofile,"%c",cnam[IndexToDstWithMask(c,writeMask)]);
		}
	}
}

void printDstReg(int32_t index, int32_t writeMask, int32_t readSize)
{
	if ( index >= 32768 ) {
		fprintf(ofile,"i%d",index-32768);
	} else {
		fprintf(ofile,"f%d",index);
	}
	if ( writeMask != 0xF ) {
		fprintf(ofile,".");
		const char cnam[4] = { 'r','g','b','a' };
		for ( int c=0; c<readSize; c++ ) {
			fprintf(ofile,"%c",cnam[IndexToDstWithMask(c,writeMask)]);
		}
	}
}

void printSrcReg(int32_t index, int32_t readSwizzle, int32_t readSize)
{
	if ( index >= 32768 ) {
		fprintf(ofile,"i%d",index-32768);
	} else {
		fprintf(ofile,"f%d",index);
	}
	if ( readSwizzle != 0x1b ) {
		fprintf(ofile,".");
		const char cnam[4] = { 'r','g','b','a' };
		for ( int c=0; c<readSize; c++ ) {
			fprintf(ofile,"%c",cnam[Swizzle(c,readSwizzle)]);
		}
	}
}

void parse()
{
	bool firstins = true;
	
	for ( ; available() ; ) {
		
		uint32_t op0 = readUint32();
		uint32_t op1 = readUint32();
		
		int32_t op 				= ( op0 >> 24 ) ;
		int32_t dst				= ( op0 >>  8 ) & 0xFFFF;
		int32_t writeMask		= ( op0 >>  4 ) & 0xF;
		int32_t matrixSize		= ( op0 >>  2 ) & 0x3;
		int32_t readSize		= ( op0  &  3 ) + 1;
		int32_t src				= ( op1 >> 16 ) & 0xFFFF;
		int32_t readSwizzle		= ( op1 >>  8 ) & 0xFF;
		
		dst = littleToBig16(uint16_t(dst));
		src = littleToBig16(uint16_t(src));
		
		if ( op <= pbjSelect ) {
			if ( matrixSize == 0 ) {
				if ( op == pbjLoadConstant ) {
					
				} else if ( op == pbjLength ) { 
					if ( BitCount(writeMask) != pbjSampleSizeScalar ) {
						fprintf(stderr, "(%s) sizeof( dst ) != 1\n",opNamesLo[op&0x7F]);
						goto error; 
					}
				} else if ( op == pbjSampleNearest || op == pbjSampleBilinear ) {
					if ( readSize != pbjSampleSizeVector2 ) {
						fprintf(stderr, "(%s) sizeof( src ) != 2\n",opNamesLo[op&0x7F]);
						goto error; 
					}
				} else if ( op == pbjSelect ) {
					if( readSize != 1 ) { 
						fprintf(stderr, "(%s) sizeof( src ) != 1\n",opNamesLo[op&0x7F]);
						goto error; 
					}	
				} else {
					if( BitCount(writeMask) != readSize ) { 
						fprintf(stderr, "(%s) sizeof( dst ) != sizeof( src )\n",opNamesLo[op&0x7F]);
						goto error; 
					}	
				}
			} else {
				if ( isIntReg(src) || isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation not allowed on integer types\n",opNamesLo[op&0x7F]);
					goto error; 
				}
			}
		}
		
		switch ( op ) {
			case	pbjNop: 
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				fprintf(ofile,"\t%s\n",opNamesLo[op]);
				break;
				
			case	pbjAdd:
			case	pbjSubtract:			
			case	pbjMultiply:	
			case	pbjDivide:
			case	pbjMatrixMatrixMultiply:
			case	pbjAtan2:			
			case	pbjPow:				
			case	pbjMod:				
			case	pbjMin:				
			case	pbjMax:				
			case	pbjStep: 
			case	pbjCopy:					
			case	pbjFloatToInt:
			case	pbjIntToFloat: 
			case	pbjReciprocal:
			case	pbjSin:					
			case	pbjCos:					
			case	pbjTan:					
			case	pbjASin:					
			case	pbjACos:				
			case	pbjATan:					
			case	pbjExp:					
			case	pbjExp2:					
			case	pbjLog:					
			case	pbjLog2:					
			case	pbjSqrt:					
			case	pbjRSqrt:				
			case	pbjAbs:					
			case	pbjSign:					
			case	pbjFloor:				
			case	pbjCeil:					
			case	pbjFract:
			case	pbjFloatToBool:
			case	pbjIntToBool: {	
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					if ( writeMask != 0 ) {
						fprintf(stderr, "(%s) (write mask:%d) write mask not allowed\n",opNamesLo[op&0x7F],writeMask);
						goto error;
					}
					switch ( op ) {
						case	pbjCopy:
						case	pbjAdd:
						case	pbjSubtract:
						case	pbjMultiply:
						case	pbjReciprocal:
						case	pbjMatrixMatrixMultiply: {
							fprintf(ofile,"\t%s%s\t\t%d, %d\n",opNamesLo[op],matrixNames[matrixSize],dst,src);
						} break;
						default: {
							fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
							goto error;
						} break;
					}
				} else {
					bool dstInt = false;
					bool srcInt = false;
					switch ( op ) {
						case	pbjAdd:
							if ( isIntReg(dst) ) {
								dstInt = true;
								srcInt = true;
							}
							break;
						case	pbjSubtract:			
							if ( isIntReg(dst) ) {
								dstInt = true;
								srcInt = true;
							}
							break;
						case	pbjMultiply:			
							if ( isIntReg(dst) ) {
								dstInt = true;
								srcInt = true;
							}
							break;
						case	pbjDivide:
							if ( isIntReg(dst) ) {
								dstInt = true;
								srcInt = true;
							}
							break;
					}
					if ( op == pbjCopy ) {
						if ( isIntReg(dst) != isIntReg(src) ) {
							fprintf(stderr, "(%s) source and destination register type mismatch\n",opNamesLo[op&0x7F]);
							goto error;
						}
					} else {
						if ( isIntReg(dst) != dstInt ) {
							fprintf(stderr, "(%s) invalid destination register type\n",opNamesLo[op&0x7F]);
							goto error;
						}
						if ( isIntReg(src) != srcInt ) {
							fprintf(stderr, "(%s) invalid source register type\n",opNamesLo[op&0x7F]);
							goto error;
						}
					}
					
					fprintf(ofile,"\t");
					fprintf(ofile,opNamesLo[op]);
					if ( strlen(opNamesLo[op])<4) {
						fprintf(ofile,"\t\t");
					} else {
						fprintf(ofile,"\t");
					}
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,"\n");
				}
			} break;
				
			case	pbjBoolToInt:
			case	pbjBoolToFloat: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( !isIntReg(src) ) {
					fprintf(stderr, "(%s) invalid source register type\n",opNamesLo[op&0x7F]);
					goto error;
				}
				if ( isIntReg(dst) ) {
					fprintf(stderr, "(%s) invalid destination register type\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjAny:
			case	pbjAll: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( !isIntReg(src) ) {
					fprintf(stderr, "(%s) invalid source register type\n",opNamesLo[op&0x7F]);
					goto error;
				}
				if ( !isIntReg(dst) ) {
					fprintf(stderr, "(%s) invalid destination register type\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjVectorMatrixMultiply: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( BitCount(writeMask) != (matrixSize+1) ) {
					fprintf(stderr, "(%s) sizeof( dst ) != sizeof( src )\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s%s\t",opNamesLo[op],matrixNames[matrixSize]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", f%d\n",src);
			} break;
				
			case	pbjMatrixVectorMultiply: {	
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( BitCount(writeMask) != (matrixSize+1) ) {
					fprintf(stderr, "(%s) sizeof( dst ) != sizeof( src )\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s%s\t",opNamesLo[op],matrixNames[matrixSize]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", f%d\n",src);
			} break;
				
			case	pbjNormalize: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( isIntReg(src) || isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation now allowed on integer types\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( readSize == pbjSampleSizeScalar ) {
					fprintf(stderr, "(%s) trying to normalize a scalar\n",opNamesLo[op&0x7F]);
					goto error;
				} else {
					fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,"\n");
				}
			} break;
				
			case	pbjDistance:
			case	pbjLength: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( isIntReg(src) || isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation now allowed on integer values\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( readSize == pbjSampleSizeScalar ) {
					fprintf(stderr, "(%s) trying to get the length of a scalar\n",opNamesLo[op&0x7F]);
					goto error;
				} else {
					fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
					printDstReg(dst,writeMask,1);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,"\n");
				}
			} break;
				
			case	pbjDotProduct: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( isIntReg(src) || isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation now allowed on integer values\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjCrossProduct: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( isIntReg(src) || isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation now allowed on integer values\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( readSize != 3 ) {
					fprintf(stderr, "(%s) vector type not supported\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjEqual:				
			case	pbjNotEqual:  {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(ofile,"\t%s%s\t\t%d, %d\n",opNamesLo[op],matrixNames[matrixSize],dst,src);
				} else {
					fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,"\n");
				}
			} break;
				
			case	pbjVectorEqual:
			case	pbjVectorNotEqual:
			case	pbjLessThan:				
			case	pbjLessThanEqual: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( isIntReg(src) != isIntReg(dst) ) {
					fprintf(stderr, "(%s) register type mismatch\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\t%s\t",opNamesLo[op]);
				if ( strlen(opNamesLo[op]) < 4 ) {
					fprintf(ofile,"\t");
				}
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjLogicalOr:
			case	pbjLogicalXor:
			case	pbjLogicalAnd:
			case	pbjLogicalNot: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( matrixSize ) {
					fprintf(stderr, "(%s) operation now allowed on matrices\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( !isIntReg(src) || !isIntReg(dst) ) {
					fprintf(stderr, "(%s) operation now allowed on float values\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				if ( readSize != pbjSampleSizeScalar ) { 
					fprintf(stderr, "(%s) ( sizeof( dst ) = sizeof( src ) ) != 1\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n");
			} break;
				
			case	pbjSampleBilinear:
			case	pbjSampleNearest: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( isIntReg(dst) ) {
					fprintf(stderr, "(%s) Can't sample into integer registers\n",opNamesLo[op&0x7F]);
					goto error; 
				}
				fprintf(ofile,"\t%s\t",opNamesLo[op]);
				printDstReg(dst,writeMask,readSize);
				fprintf(ofile,", ");
				printSrcReg(src,readSwizzle,readSize);
				int32_t txtId = ( op1 ) & 0xFF;
				fprintf(ofile,", t%d\n",txtId);
			} break;
				
			case	pbjLoadConstant: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				union {
					uint8_t valuec[4];
					float valuef;
					uint32_t valuei;
				};
				valuei = op1;
				if ( isIntReg(dst) ) {
					fprintf(ofile,"\tset\t\t");
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", %d\n",valuei);
				} else {
					valuei = 	(((uint32_t)(valuec[3]))<<24)|
					(((uint32_t)(valuec[2]))<<16)|
					(((uint32_t)(valuec[1]))<< 8)|
					(((uint32_t)(valuec[0]))<< 0);
					fprintf(ofile,"\tset\t\t");
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", %g\n",valuef);
				}
			} break;
				
			case	pbjSelect: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				uint32_t op2 = readUint32();
				uint32_t op3 = readUint32();
				
				uint16_t src0 = op2>>16;
				uint16_t src1 = op3>>16;
				
				int32_t readSize0	 = ( ( op2 >>  6 ) & 0x3) + 1;
				int32_t readSwizzle0 = (   op2 >>  8 ) & 0xFF;
				int32_t readSize1	 = ( ( op3 >>  6 ) & 0x3) + 1;
				int32_t readSwizzle1 = (   op3 >>  8 ) & 0xFF;
				
				src0 = littleToBig16(src0);
				src1 = littleToBig16(src1);
				
				if ( !isIntReg(src) ) {
					fprintf(stderr, "(%s) source needs to be of type int\n",opNamesLo[op&0x7F]);
					goto error;
				}
				
				if ( readSize0 != readSize1 ) {
					fprintf(stderr, "(%s) sizeof(src1) != sizeof(src2)\n",opNamesLo[op&0x7F]);
					goto error;
				}
				
				if ( matrixSize ) {
					if ( !isIntReg(src0) || !isIntReg(src1) ) {
						fprintf(stderr, "(%s) source needs to be of type int\n",opNamesLo[op&0x7F]);
						goto error;
					}
					fprintf(ofile,"\t%s%s\t\t",opNamesLo[op],matrixNames[matrixSize]);
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,", f%d, f%d\n",src0,src1);
				} else {
					if ( isIntReg(src0) != isIntReg(src1) ||
						isIntReg(src0) != isIntReg(dst) ) {
						fprintf(stderr, "(%s) source register type mismatch\n",opNamesLo[op&0x7F]);
						goto error;
					}
					fprintf(ofile,"\t%s\t\t",opNamesLo[op]);
					printDstReg(dst,writeMask,readSize);
					fprintf(ofile,", ");
					printSrcReg(src,readSwizzle,readSize);
					fprintf(ofile,", ");
					printSrcReg(src0,readSwizzle0,readSize);
					fprintf(ofile,", ");
					printSrcReg(src1,readSwizzle1,readSize);
					fprintf(ofile,"\n");
				}
			} break;
				
			case	pbjIf: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				if ( !isIntReg(src) ) {
					fprintf(stderr, "(%s) source needs to be of type int\n",opNamesLo[op&0x7F]);
					goto error;
				}
				fprintf(ofile,"\n\t%s\t\t",opNamesLo[op]);
				printSrcReg(src,readSwizzle,readSize);
				fprintf(ofile,"\n\n");
			} break;
				
			case	pbjElse: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				fprintf(ofile,"\n\t%s\t\t\n\n",opNamesLo[op]);
			} break;
				
			case	pbjEndif: {
				if ( firstins ) { firstins = false; fprintf(ofile,"\n;----------------------------------------------------------\n\n"); }
				fprintf(ofile,"\n\t%s\t\t\n\n",opNamesLo[op]);
			} break;
				
			case	pbjParameterMetaData:
			case	pbjKernelMetaData: {
				
				seek(-7);
				
				int32_t type = readUint8();
				
				if ( type == pbjTypeString ) {
					
					const char *name = readStr();
					const char *meta = readStr();
					
					if (op == pbjParameterMetaData) {
						fprintf(ofile,"\tmeta\t\t\"%s\", \"%s\"",name,meta);
					} else {
						fprintf(ofile,"\tkernel\t\t\"%s\", \"%s\"",name,meta);
					}
					
				} else {
					
					const char *name = readStr();
					
					if (op == pbjParameterMetaData) {
						
						fprintf(ofile,"\tmeta\t\t\"%s\"",name);
						
						int numElem = 0;
						
						switch ( type ) {
							case	pbjTypeFloat4x4:
								numElem += 7;
							case	pbjTypeFloat3x3:
								numElem += 5;
							case	pbjTypeFloat2x2:
							case	pbjTypeFloat4:
								numElem++;
							case	pbjTypeFloat3:
								numElem++;
							case	pbjTypeFloat2:
								numElem++;
							case	pbjTypeFloat:
								numElem++;
								for ( int c=0; c<numElem; c++ ) {
									fprintf(ofile,", %g",readFloat());
								}
								break;
							case	pbjTypeBool4:
							case	pbjTypeInt4:
								numElem++;
							case	pbjTypeBool3:
							case	pbjTypeInt3:
								numElem++;
							case	pbjTypeBool2:
							case	pbjTypeInt2:
								numElem++;
							case	pbjTypeBool:
							case	pbjTypeInt:
								numElem++;
								for ( int c=0; c<numElem; c++ ) {
									fprintf(ofile,", %d",(littleToBig16(readUint16())<<15)>>15);
								}
								break;
						}
					} else {
						
						fprintf(ofile,"\tkernel\t\t\"%s\"",name);
						switch ( type ) {
							case	pbjTypeInt: {
								int32_t i = (littleToBig16(readUint16())<<15)>>15;
								fprintf(ofile,", %d",i);
							} break;
							default:
								goto error;
						}
					}
				}
				
				fprintf(ofile,"\n");
			} break;
				
			case	pbjParameterData: {
				seek(-7);
				int32_t qualifier = readUint8();
				int32_t type = readUint8();
				
				if ( type == pbjTypeString || qualifier > 2 || qualifier < 1) {
					goto error;
				} else {
					
					dst = littleToBig16(readUint16());
					writeMask = readUint8();
					
					const char *paramName = readStr();
					
					fprintf(ofile,"\n\tparameter\t\"%s\", %s, ",paramName, typeNames[type] );
					printDstReg(dst,writeMask,typeSizes[type]);
					fprintf(ofile,", %s",qualifierName[qualifier]);
					fprintf(ofile,"\n");
				}
				
			} break;
				
			case	pbjTextureData: {
				seek(-7);
				int32_t index = readUint8();
				int32_t channels = readUint8();
				fprintf(ofile,"\n\ttexture\t\t\"%s\", t%d",readStr(),index);
				const char cnam[4] = { 'r','g','b','a' };
				if ( channels != 4 ) {
					fprintf(ofile,".");
					for ( int c=0; c<channels; c++ ) {
						fprintf(ofile,"%c",cnam[c]);
					}
				}
				fprintf(ofile,"\n");
			} break;
				
			case	pbjKernelName: {
				seek(-7);
				fprintf(ofile,"\tname\t\t\"%s\"\n",readStrN(littleToBig16(readUint16())));
			} break;
				
			case	pbjVersionData: {
				seek(-7);
				uint8_t a0 = readUint8();
				uint8_t a1 = readUint8();
				uint8_t a2 = readUint8();
				uint8_t a3 = readUint8();
				int32_t version = (a0)|(a1<<8)|(a2<<16)|(a3<<24);
				if ( version != 1 ) {
					fprintf(stderr, "(?) unsupported pbj byte code version %d\n",version);
					goto error;
				}
				fprintf(ofile,"\tversion\t\t%d\n",version);
			} break;
				
			default: {
				if ( !available() ) {
					return;
				}
				fprintf(stderr, "(?) unknown opcode %02x\n",op);
				goto error;
			} break;
		}
	}
error:
	return;
}

int main(int argc, char *argv[])
{
	if ( argc > 1) {
		for (int32_t c = 1; c < argc; c++) {
			if (argv[c][0] == '-') {
				if (argv[c][1] == 'o') {
					if ( argc < c+1 ) {
						fprintf(stderr,"Missing output file name.\n\n");
						return -1;
					}
					if ( ( ofile = fopen(argv[c+1],"wb") ) == 0 ) {
						fprintf(stderr,"Could not open output file '%s'\n\n",argv[c+1]);
						return -1;
					}
				}
			}
		}
		if ( ofile == 0 ) {
			ofile = stdout;
		}
		if ( ( ifile = fopen(argv[1],"rb") ) != 0 ) {
			parse();
			fclose(ifile);
			return 0;
		}
		if ( ofile && ofile != stdout ) {
			fclose(ofile);
		}
	}
	fprintf(stderr,"\nCan't open input file.\n\n");
	fprintf(stderr,"Usage: 'dpjb input.pbj -o output.pba' or 'dpjb input.pbj'\n\n");
	return -1;
}
