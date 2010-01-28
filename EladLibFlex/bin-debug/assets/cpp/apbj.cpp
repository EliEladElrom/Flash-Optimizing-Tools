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
#include <algorithm>
#include <iostream>
#include <fstream>
#include <map>
#include <string>
#include <sstream>
#include <vector>
#include <stdint.h>

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

using namespace std;

int32_t linen = 1;

static ifstream ifile;
static ofstream ofile;

static map<string, int> opcodes;
static map<string, int> types;
static map<string, int> matrices;

const uint32_t typeSizes[] = {
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
	1,
	1,
	2,
	3,
	4,
};

void init_map() {

	opcodes["nop"] = pbjNop;
	opcodes["add"] = pbjAdd;
	opcodes["sub"] = pbjSubtract;
	opcodes["mul"] = pbjMultiply;
	opcodes["div"] = pbjDivide;
	opcodes["atan2"] = pbjAtan2;
	opcodes["pow"] = pbjPow;
	opcodes["mod"] = pbjMod;
	opcodes["min"] = pbjMin;
	opcodes["max"] = pbjMax;
	opcodes["step"] = pbjStep;
	opcodes["rcp"] = pbjReciprocal;
	opcodes["sin"] = pbjSin;
	opcodes["cos"] = pbjCos;
	opcodes["tan"] = pbjTan;
	opcodes["asin"] = pbjASin;
	opcodes["acos"] = pbjACos;
	opcodes["atan"] = pbjATan;
	opcodes["exp"] = pbjExp;
	opcodes["exp2"] = pbjExp2;
	opcodes["log"] = pbjLog;
	opcodes["log2"] = pbjLog2;
	opcodes["sqr"] = pbjSqrt;
	opcodes["rsqr"] = pbjRSqrt;
	opcodes["abs"] = pbjAbs;
	opcodes["sign"] = pbjSign;
	opcodes["floor"] = pbjFloor;
	opcodes["ceil"] = pbjCeil;
	opcodes["fract"] = pbjFract;
	opcodes["mov"] = pbjCopy;
	opcodes["ftoi"] = pbjFloatToInt;
	opcodes["itof"] = pbjIntToFloat;
	opcodes["norm"] = pbjNormalize;
	opcodes["len"] = pbjLength;
	opcodes["dist"] = pbjDistance;
	opcodes["dot"] = pbjDotProduct;
	opcodes["cross"] = pbjCrossProduct;
	opcodes["equ"] = pbjEqual;
	opcodes["neq"] = pbjNotEqual;
	opcodes["ltn"] = pbjLessThan;
	opcodes["lte"] = pbjLessThanEqual;
	opcodes["not"] = pbjLogicalNot;
	opcodes["and"] = pbjLogicalAnd;
	opcodes["or"] = pbjLogicalOr;
	opcodes["xor"] = pbjLogicalXor;
	opcodes["texn"] = pbjSampleNearest;
	opcodes["texb"] = pbjSampleBilinear;
	opcodes["set"] = pbjLoadConstant;
	opcodes["sel"] = pbjSelect;
	opcodes["if"] = pbjIf;
	opcodes["else"] = pbjElse;
	opcodes["end"] = pbjEndif;
	opcodes["ftob"] = pbjFloatToBool;
	opcodes["btof"] = pbjBoolToFloat;
	opcodes["itob"] = pbjIntToBool;
	opcodes["btoi"] = pbjBoolToInt;
	opcodes["vequ"] = pbjVectorEqual;
	opcodes["vneq"] = pbjVectorNotEqual;
	opcodes["any"] = pbjAny;
	opcodes["all"] = pbjAll;
	opcodes["kernel"] = pbjKernelMetaData;
	opcodes["parameter"] = pbjParameterData;
	opcodes["meta"] = pbjParameterMetaData;
	opcodes["texture"] = pbjTextureData;
	opcodes["name"] = pbjKernelName;
	opcodes["version"] = pbjVersionData;	

	opcodes["mov2x2"] = pbjCopy;
	opcodes["mov3x3"] = pbjCopy;
	opcodes["mov4x4"] = pbjCopy;
	opcodes["add2x2"] = pbjAdd;
	opcodes["add3x3"] = pbjAdd;
	opcodes["add4x4"] = pbjAdd;
	opcodes["sub2x2"] = pbjSubtract;
	opcodes["sub3x3"] = pbjSubtract;
	opcodes["sub4x4"] = pbjSubtract;
	opcodes["mul2x2"] = pbjMultiply;
	opcodes["mul3x3"] = pbjMultiply;
	opcodes["mul4x4"] = pbjMultiply;
	opcodes["rcp2x2"] = pbjReciprocal;
	opcodes["rcp3x3"] = pbjReciprocal;
	opcodes["rcp4x4"] = pbjReciprocal;
	opcodes["equ2x2"] = pbjEqual;
	opcodes["equ3x3"] = pbjEqual;
	opcodes["equ4x4"] = pbjEqual;
	opcodes["neq2x2"] = pbjNotEqual;
	opcodes["neq3x3"] = pbjNotEqual;
	opcodes["neq4x4"] = pbjNotEqual;
	opcodes["mmmul2x2"] = pbjMatrixMatrixMultiply;
	opcodes["mmmul3x3"] = pbjMatrixMatrixMultiply;
	opcodes["mmmul4x4"] = pbjMatrixMatrixMultiply;
	opcodes["vmmul2x2"] = pbjVectorMatrixMultiply;
	opcodes["vmmul3x3"] = pbjVectorMatrixMultiply;
	opcodes["vmmul4x4"] = pbjVectorMatrixMultiply;
	opcodes["mvmul2x2"] = pbjMatrixVectorMultiply;
	opcodes["mvmul3x3"] = pbjMatrixVectorMultiply;
	opcodes["mvmul4x4"] = pbjMatrixVectorMultiply;
	opcodes["sel2x2"] = pbjSelect;
	opcodes["sel3x3"] = pbjSelect;
	opcodes["sel4x4"] = pbjSelect;

	types["float"] = 1;
	types["float2"] = 2;
	types["float3"] = 3;
	types["float4"] = 4;
	types["matrix2x2"] = 5;
	types["matrix3x3"] = 6;
	types["matrix4x4"] = 7;
	types["int"] = 8;
	types["int2"] = 9;
	types["int3"] = 10;
	types["int4"] = 11;
	types["bool"] = 12;
	types["bool2"] = 13;
	types["bool3"] = 14;
	types["bool4"] = 15;
	
	matrices["2x2"] = 1;
	matrices["3x3"] = 2;
	matrices["4x4"] = 3;
}

static string error_line;

void write_int16(int16_t value)
{
	ofile << uint8_t(value&0xFF);
	ofile << uint8_t((value>>8)&0xFF);
}

void write_float(float value)
{
	union {
		float   valuef;
		uint8_t valuec[4];
	};
	valuef = value;
	ofile << valuec[3];
	ofile << valuec[2];
	ofile << valuec[1];
	ofile << valuec[0];
}

void error(const char *str)
{
	cerr << "\n";
	cerr << str;
	cerr << " Line: ";
	cerr << linen;
	cerr << "\n";
	cerr << "\n";
	cerr << error_line;
	cerr << "\n";
	exit(-1);
}

vector<string> tokenize(const string &input, vector<int> &tokenTypes)
{
	string delimiters(" \t\n\r,;\"");
	vector<string> tokens;
	string token;
	string::size_type last_pos = 0;
	string::size_type pos = 0;
	while(true) {
		pos = input.find_first_of(delimiters, last_pos);
		if( pos == string::npos ) {
			token = input.substr(last_pos);
			if ( token.size() ) {
				std::transform(token.begin(), token.end(), token.begin(), static_cast < int(*)(int) > (tolower));
				tokens.push_back(token);
				tokenTypes.push_back(0);
			}
			break;
		} else {
			if (input[pos] == ';' ) {
				break;
			}
			if (input[pos] == '\"' ) {
				string::size_type end_pos = input.find_first_of(string("\""), pos+1);
				if( pos == string::npos ) {
					error("string not terminated.");
				}
				token = input.substr(pos+1, end_pos - pos - 1);
				tokenTypes.push_back(1);
				tokens.push_back(token);
				last_pos = end_pos + 1;
				continue;
			}
			token = input.substr(last_pos, pos - last_pos);
			if ( token.size() ) {
				std::transform(token.begin(), token.end(), token.begin(), static_cast < int(*)(int) > (tolower));
				tokens.push_back(token);
				tokenTypes.push_back(0);
			}
			last_pos = pos + 1;
		}
	}
	return tokens;
}

uint32_t parse_register_number(const string &param)
{
	if ( param.find_first_of("f",0) == string::npos &&
		 param.find_first_of("i",0) == string::npos) {
		error("invalid register type.");
	}
	uint32_t register_n = 0;
	string::size_type dot_pos = param.find_first_of(".",0);
	if ( dot_pos == string::npos ) {
		stringstream ss(param.substr(1));
		ss >> register_n;
	} else {
		stringstream ss(param.substr(1,dot_pos));
		ss >> register_n;
	}
	if ( param.find_first_of("f",0) != string::npos) {
		return register_n;
	} else {
		return register_n+32768;
	}
}

uint32_t parse_writemask(const string &param)
{
	string::size_type dot_pos = param.find_first_of(".");
	if ( dot_pos == string::npos ) {
		return 0xF;
	}
	uint32_t write_mask = 0;
	const char *cnam = "rgba";
	for ( string::size_type c=dot_pos+1; c<param.size(); c++ ) {
		bool found = false;
		for ( int32_t d=0; d<4; d++ ) {
			if ( param[c] == cnam[d] ) {
				write_mask |= 1<<(3-d);
				found = true;
				break;
			}
		}
		if (!found) {
			error("invalid write mask.");
		}
	}
	return write_mask;
}

uint32_t parse_sourceselect(const string &param)
{
	string::size_type dot_pos = param.find_first_of(".");
	if ( dot_pos == string::npos ) {
		return 0x1b;
	}
	uint32_t select = 0;
	const char *cnam = "rgba";
	int32_t count = 0;
	for ( string::size_type c=dot_pos+1; c<param.size(); c++ ) {
		select <<= 2;
		bool found = false;
		for ( int32_t d=0; d<4; d++ ) {
			if ( param[c] == cnam[d] ) {
				select  |= d;
				found = true;
				count++;
				break;
			}
		}
		if (!found) {
			error("invalid source select.");
		}
	}
	for ( int32_t c=count; c<4; c++ ) {
		select <<= 2;
	}
	return select;
}

uint32_t parse_sourcelen(const string &param)
{
	string::size_type dot_pos = param.find_first_of(".");
	if ( dot_pos == string::npos ) {
		return 3;
	}
	const char *cnam = "rgba";
	uint32_t size = 0;
	for ( string::size_type c=dot_pos+1; c<param.size(); c++ ) {
		bool found = false;
		for ( int32_t d=0; d<4; d++ ) {
			if ( param[c] == cnam[d] ) {
				size++;
				found = true;
				break;
			}
		}
		if (!found) {
			error("invalid source length.");
		}
	}
	if ( size == 0 ) {
		error("invalid source length.");
	}
	return size-1;
}

uint32_t matrix_type(const string &param)
{
	string::size_type x_pos = param.find_first_of("x");
	if (  x_pos == string::npos ) {
		return 0;
	}
	string mtx_str = param.substr(x_pos-1,x_pos+1);
	return matrices[mtx_str];
}

void parse()
{
	uint8_t meta_type = 0;
	
	string line;
	for ( ; getline(ifile, line) ;  ) {
		error_line = line;
		vector<int> tokenTypes;
		vector<string> tokens = tokenize(line, tokenTypes);
		if ( !tokens.size() ) {
			continue;
		}
		int32_t op = opcodes[tokens[0]];
		ofile << uint8_t(op);
		switch ( op ) {
			case	pbjNop: {
						if ( tokens.size() < 1 ) error("missing parameter(s).");
						if ( tokens.size() > 1 ) error("too many parameters.");
						write_int16(0);
						ofile << uint8_t(0);
						write_int16(0);
						ofile << uint8_t(0);
						ofile << uint8_t(0);
					} break;
					
			case	pbjAdd:
			case	pbjSubtract:			
			case	pbjMultiply:	
			case	pbjDivide:
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
			case	pbjDistance:
			case	pbjNormalize:
			case	pbjLength:
			case	pbjCrossProduct:
			case	pbjDotProduct:
			case	pbjEqual:				
			case	pbjNotEqual:			
			case	pbjVectorEqual:
			case	pbjVectorNotEqual:
			case	pbjLessThan:				
			case	pbjLessThanEqual: 
			case	pbjAny:
			case	pbjAll:
			case	pbjFloatToBool:
			case	pbjIntToBool:
			case	pbjBoolToInt:
			case	pbjBoolToFloat: 
			case	pbjMatrixMatrixMultiply:
			case	pbjLogicalOr:
			case	pbjLogicalXor:
			case	pbjLogicalAnd:
			case	pbjLogicalNot:	{	
						if ( tokens.size() < 3 ) error("missing parameter(s).");
						if ( tokens.size() > 3 ) error("too many parameters.");
						if ( matrix_type(tokens[0]) ) {
							if ( parse_writemask(tokens[1]) != 0xF ||
								 parse_writemask(tokens[2]) != 0xF ) {
								error("invalid register type.");
							}
							write_int16(parse_register_number(tokens[1]));
							ofile << uint8_t(matrix_type(tokens[0])<<2);
							write_int16(parse_register_number(tokens[2]));
							write_int16(0);
						} else {
							uint32_t dst = parse_register_number(tokens[1]);
							uint32_t src = parse_register_number(tokens[2]);
							switch ( op ) {
								case	pbjCopy:
								case	pbjAdd:
								case	pbjSubtract:			
								case	pbjMultiply:	
								case	pbjDivide:
								case	pbjEqual:				
								case	pbjNotEqual:			
								case	pbjVectorEqual:
								case	pbjVectorNotEqual:
								case	pbjLessThan:				
								case	pbjLessThanEqual: 
											if ( ( src >= 32768 && dst < 32768 ) ||
												 ( src < 32768 && dst >= 32768 ) ) {
												error("register type mismatch.");
											}
										break;
								case	pbjFloatToInt: {
											if ( src >= 32768 || dst < 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjIntToFloat: {
											if ( src < 32768 || dst >= 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjFloatToBool: {
											if ( src >= 32768 || dst < 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjIntToBool: {
											if ( src < 32768 || dst < 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjBoolToInt: {
											if ( src < 32768 || dst < 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjBoolToFloat: {
											if ( src < 32768 || dst >= 32768 ) {
												error("invalid register type.");
											}
										} break;
								case	pbjAny:
								case	pbjAll:
								case	pbjLogicalOr:
								case	pbjLogicalXor:
								case	pbjLogicalAnd:
								case	pbjLogicalNot: {
											if ( src < 32768 || dst < 32768 ) {
												error("invalid register type.");
											}
										} break;
								default: {
											if ( src >= 32768 || dst >= 32768 ) {
												error("invalid register type.");
											}
										} break;
							}
							write_int16(dst);
							ofile << uint8_t((parse_writemask(tokens[1])<<4)|(parse_sourcelen(tokens[2])));
							write_int16(src);
							ofile << uint8_t(parse_sourceselect(tokens[2]));
							ofile << uint8_t(0);
						}
					} break;

			case	pbjMatrixVectorMultiply:
			case	pbjVectorMatrixMultiply: {
						if ( tokens.size() < 3 ) error("missing parameter(s).");
						if ( tokens.size() > 3 ) error("too many parameters.");
						write_int16(parse_register_number(tokens[1]));
						ofile << uint8_t((parse_writemask(tokens[1])<<4)|(matrix_type(tokens[0])<<2));
						write_int16(parse_register_number(tokens[2]));
						write_int16(0);
					} break;
					
			case	pbjSampleBilinear:
			case	pbjSampleNearest: {
						if ( tokens.size() < 4 ) error("missing parameter(s).");
						if ( tokens.size() > 4 ) error("too many parameters.");
						write_int16(parse_register_number(tokens[1]));
						ofile << uint8_t((parse_writemask(tokens[1])<<4)|(parse_sourcelen(tokens[2])));
						write_int16(parse_register_number(tokens[2]));
						ofile << uint8_t(parse_sourceselect(tokens[2]));
						if ( tokens[3].find_first_of("t",0) == string::npos ) {
							error("invalid texture type.");
						}
						int32_t texture_id = 0;
						stringstream ss(tokens[3].substr(1));
						ss >> texture_id;
						ofile << uint8_t(texture_id);
					} break;

			case	pbjLoadConstant: {
						if ( tokens.size() < 3 ) error("missing parameter(s).");
						if ( tokens.size() > 3 ) error("too many parameters.");
						uint32_t reg = parse_register_number(tokens[1]);
						write_int16(reg);
						ofile << uint8_t((parse_writemask(tokens[1])<<4));
						if ( reg < 32768 ) {
							stringstream ss(tokens[2]);
							float value = 0;
							ss >> value;
							write_float(value);
						} else {
							stringstream ss(tokens[2]);
							int16_t value = 0;
							ss >> value;
							write_int16(value);
							write_int16(0);
						}
					} break;
					
			case	pbjSelect: {
						if ( tokens.size() < 5 ) error("missing parameter(s).");
						if ( tokens.size() > 5 ) error("too many parameters.");
						if ( matrix_type(tokens[0]) ) {
							if ( tokens[1].find_first_of(".",0) != string::npos ||
								 tokens[2].find_first_of(".",0) != string::npos ||
								 tokens[3].find_first_of(".",0) != string::npos ||
								 tokens[4].find_first_of(".",0) != string::npos ) {
								 error("invalid register type.");
							}
							write_int16(parse_register_number(tokens[1]));
							uint32_t len = parse_sourcelen(tokens[2]);
							if ( parse_sourcelen(tokens[1]) != len ) {
								error("invalid dst length, must match src.");
							}
							ofile << uint8_t(matrix_type(tokens[0])<<2);
							uint32_t reg = parse_register_number(tokens[2]);
							if ( reg < 32768 ) {
								error("src must be an integer.");
							}
							write_int16(reg);
							ofile << uint8_t(0);
							ofile << uint8_t(0);
							if ( parse_sourcelen(tokens[2]) != len ) {
								error("invalid src1 length, must match src.");
							}
							write_int16(parse_register_number(tokens[3]));
							write_int16(0);
							if ( parse_sourcelen(tokens[2]) != len ) {
								error("invalid src2 length, must match src.");
							}
							write_int16(parse_register_number(tokens[4]));
							write_int16(0);
						} else {
							write_int16(parse_register_number(tokens[1]));
							uint32_t len = parse_sourcelen(tokens[2]);
							if ( parse_sourcelen(tokens[1]) != len ) {
								error("invalid dst length, must match src.");
							}
							ofile << uint8_t((parse_writemask(tokens[1])<<4)|len);
							uint32_t reg = parse_register_number(tokens[2]);
							if ( reg < 32768 ) {
								error("src must be an integer.");
							}
							write_int16(reg);
							ofile << uint8_t(parse_sourceselect(tokens[2]));
							ofile << uint8_t(0);
							if ( parse_sourcelen(tokens[2]) != len ) {
								error("invalid src1 length, must match src.");
							}
							write_int16(parse_register_number(tokens[3]));
							ofile << uint8_t(parse_sourceselect(tokens[3]));
							ofile << uint8_t(parse_sourcelen(tokens[3])<<6);
							if ( parse_sourcelen(tokens[2]) != len ) {
								error("invalid src2 length, must match src.");
							}
							write_int16(parse_register_number(tokens[4]));
							ofile << uint8_t(parse_sourceselect(tokens[4]));
							ofile << uint8_t(parse_sourcelen(tokens[4])<<6);
						}
					} break;

			case	pbjIf: {
						if ( tokens.size() < 2 ) error("missing parameter(s).");
						if ( tokens.size() > 2 ) error("too many parameters.");
						write_int16(0);
						uint32_t len = parse_sourcelen(tokens[1]);
						if ( len != 0 ) {
							error ("invalid source length.");
						}
						ofile << uint8_t(len);
						uint32_t reg = parse_register_number(tokens[1]);
						if ( reg < 32768 ) {
							error ("invalid register type.");
						}
						write_int16(reg);
						ofile << uint8_t(parse_sourceselect(tokens[1]));
						ofile << uint8_t(0);
					} break;

			case	pbjElse: {
						if ( tokens.size() < 1 ) error("missing parameter(s).");
						if ( tokens.size() > 1 ) error("too many parameters.");
						write_int16(0);
						ofile << uint8_t(0);
						write_int16(0);
						ofile << uint8_t(0);
						ofile << uint8_t(0);
					} break;

			case	pbjEndif: {
						if ( tokens.size() < 1 ) error("missing parameter(s).");
						if ( tokens.size() > 1 ) error("too many parameters.");
						write_int16(0);
						ofile << uint8_t(0);
						write_int16(0);
						ofile << uint8_t(0);
						ofile << uint8_t(0);
					} break;
					
			case	pbjParameterMetaData: {
						if ( tokenTypes[2] == 1 ) {
							if ( tokens.size() < 3 ) error("missing parameter(s).");
							if ( tokens.size() > 3 ) error("too many parameters.");
						} else {
							if ( tokens.size() < 2 + typeSizes[meta_type] ) error("missing parameter(s).");
							if ( tokens.size() > 2 + typeSizes[meta_type] ) error("too many parameters.");
						}
						if ( tokenTypes[2] == 1 ) {
							ofile << uint8_t(pbjTypeString);
							ofile << tokens[1];
							ofile << '\0';
							ofile << tokens[2];
							ofile << '\0';
						} else {
							ofile << uint8_t(meta_type);
							ofile << tokens[1];
							ofile << '\0';
							switch ( meta_type ) {
								case	pbjTypeFloat4x4:
								case	pbjTypeFloat3x3:
								case	pbjTypeFloat2x2:
								case	pbjTypeFloat4:
								case	pbjTypeFloat3:
								case	pbjTypeFloat2:
								case	pbjTypeFloat: {
											for ( uint32_t c=0; c<typeSizes[meta_type] ; c++ ) {
												stringstream ss(tokens[2+c]);
												float value = 0;
												ss >> value;
												write_float(value);
											}
										} break;
								case	pbjTypeBool4:
								case	pbjTypeInt4:
								case	pbjTypeBool3:
								case	pbjTypeInt3:
								case	pbjTypeBool2:
								case	pbjTypeInt2:
								case	pbjTypeBool:
								case	pbjTypeInt: {
											for ( uint32_t c=0; c<typeSizes[meta_type] ; c++ ) {
												stringstream ss(tokens[2+c]);
												int16_t value = 0;
												ss >> value;
												write_int16(value);
											}
										} break;
							}
						}
					} break;

			case	pbjKernelMetaData: {
						if ( tokens.size() < 3 ) error("missing parameter(s).");
						if ( tokens.size() > 3 ) error("too many parameters.");
						if ( tokenTypes[2] == 1 ) {
							ofile << uint8_t(pbjTypeString);
						} else {
							ofile << uint8_t(pbjTypeInt);
						}
						ofile << tokens[1];
						ofile << '\0';
						if ( tokenTypes[2] == 1 ) {
							ofile << tokens[2];
							ofile << '\0';
						} else {
							stringstream ss(tokens[2]);
							int16_t value = 0;
							ss >> value;
							write_int16(value);
						}
					} break;

			case	pbjParameterData: {
						if ( tokens.size() < 5 ) error("missing parameter(s).");
						if ( tokens.size() > 5 ) error("too many parameters.");
						if ( tokens[4] != "in" &&
							 tokens[4] != "out") {
							error("invalid parameter direction.");
						}
						uint32_t reg = parse_register_number(tokens[3]);
						if ( tokens[4] == "in" ) {
							ofile << uint8_t(1);
						} else {
							if ( reg >= 32768 ) {
								error("invalid output register type, needs to be float.");
							}
							ofile << uint8_t(2);
						}
						if ( types[tokens[2]] == 0 ) {
							error("invalid parameter type.");
						}
						meta_type = uint8_t(types[tokens[2]]);
						ofile << uint8_t(meta_type);
						write_int16(reg);
						ofile << uint8_t(parse_writemask(tokens[3]));
						ofile << tokens[1];
						ofile << '\0';
					} break;
					
			case	pbjTextureData: {
						if ( tokens.size() < 3 ) error("missing parameter(s).");
						if ( tokens.size() > 3 ) error("too many parameters.");
						if ( tokens[2].find_first_of("t",0) == string::npos ) {
							error("invalid texture type.");
						}
						int32_t texture_id = 0;
						int32_t channels   = parse_sourcelen(tokens[2])+1;
						string::size_type dot_pos = tokens[2].find_first_of(".",0);
						if ( dot_pos == string::npos ) {
							stringstream ss(tokens[2].substr(1));
							ss >> texture_id;
						} else {
							stringstream ss(tokens[2].substr(1,dot_pos));
							ss >> texture_id;
						}
						ofile << uint8_t(texture_id);
						ofile << uint8_t(channels);
						ofile << tokens[1];
						ofile << '\0';
					} break;
					
			case	pbjKernelName: {
						if ( tokens.size() < 2 ) error("missing parameter(s).");
						if ( tokens.size() > 2 ) error("too many parameters.");
						write_int16(tokens[1].size());
						ofile << tokens[1];
					} break;
					
			case	pbjVersionData: {
						int32_t version;
						if ( tokens.size() < 2 ) error("missing parameter(s).");
						if ( tokens.size() > 2 ) error("too many parameters.");
						stringstream ss(tokens[1]);
						ss >> version;
						ofile << uint8_t(version);
						ofile << uint8_t(0);
						ofile << uint8_t(0);
						ofile << uint8_t(0);
					} break;
					
			default: {
						error("unrecognized keyword.");
					} break;
		}
		linen++;
	}
}

int main(int argc, char *argv[])
{
	if ( argc > 1) {
		for (int32_t c = 1; c < argc; c++) {
			if (argv[c][0] == '-') {
				if (argv[c][1] == 'o') {
					if ( argc < c+1 ) {
						cerr << "Missing output file name.\n\n";
						return -1;
					}
					ofile.open(argv[c+1],ios::out|ios::binary);
					if ( !ofile.is_open() ) {
						cerr << "Could not open output file. '";
						cerr << argv[c+1];
						cerr << "'\n\n";
						return -1;
					}
				}
			}
		}
		if ( !ofile.is_open() ) {
			cerr << "No output file specified.\n\n";
			return -1;
		}
		ifile.open(argv[1],ios::in|ios::binary);
		if ( ifile.is_open() ) {
			init_map();
			parse();
			ifile.close();
			return 0;
		}		
		ofile.close();
	}
	cerr << "\nCan't open input file.\n\n";
	cerr << "Usage: apjb input.pba -o output.pbj\n\n";
	return -1;
}
