#ifndef _REG_ACCESS_H_
#define _REG_ACCESS_H_


#define BitMask_1    0x01
#define BitMask_2    0x03
#define BitMask_3    0x07
#define BitMask_4    0x0F
#define BitMask_5    0x1F
#define BitMask_6    0x3F
#define BitMask_7    0x7F
#define BitMask_8    0xFF




/**
* concatenation 
*/
#define __concat( x, y )    x ## y
#define concat( x, y)    __concat( x, y)

/** 
* count arguments
*/
#define __COUNT__(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, ...) a17
#define ARG_COUNT( ... ) __COUNT__(__VA_ARGS__,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1)

/**
* multiple or; this comes handy in when we need to compute the bitmask of several register fields
*/
#define __or(a1, a2, a3, a4, a5, a6, a7, a8, ... )	(a1|a2|a3|a4|a5|a6|a7|a8)
#define OR(...)	__or( __VA_ARGS__, 0,0,0,0,0,0,0,0 )



#define BitMask(width,pos)    (concat(BitMask_, width)<<pos)


// die nachfolgenden zwei macros entsprechen der Musterloesung für die Uebungen

#define ReadReg( reg, width, pos)	((reg & BitMask(width,pos))>>pos)



#define ModifyReg( reg, width, pos, value)    reg = (((reg)&~BitMask(width, pos))|((value<<pos)&BitMask(width, pos )))

#define ReadRegister(reg, field ) ReadReg( reg, concat(field,width), concat(field,pos))

#define SetRegister(reg, ... )	__setReg( reg, OR(GetValue(__VA_ARGS__)))
#define __setReg( reg, values )	reg = (uint8_t)(values);

#define UpdateRegister( reg, ... ) __updateReg(reg, OR(GetBitmask(__VA_ARGS__)), OR(GetValue(__VA_ARGS__)))
#define __updateReg(reg, bitmask, values ) reg = (uint8_t)(((reg)&~(bitmask)) |((bitmask)&(values)))


#define GetValue(...) concat( GetValue_, ARG_COUNT(__VA_ARGS__))(__VA_ARGS__)
#define GetValue_1(field) __getValue field
#define __getValue(name, value) ((value)<<concat(name,_pos))
#define GetValue_2(field1, field2) GetValue_1(field1), GetValue_1(field2)
#define GetValue_3(field1, field2, field3) GetValue_1(field1), GetValue_2(field2, field3)
#define GetValue_4(field1, field2, field3, field4) GetValue_1(field1), GetValue_3(field2, field3, field4)
#define GetValue_5(field1, field2, field3, field4, field5) GetValue_1(field1), GetValue_4(field2, field3, field4, field5)
#define GetValue_6(field1, field2, field3, field4, field5, field6) GetValue_1(field1), GetValue_5(field2, field3, field4, field5, field6)
#define GetValue_7(field1, field2, field3, field4, field5, field6, field7) GetValue_1(field1), GetValue_6(field2, field3, field4, field5, field6)


#define GetBitmask(...) concat( GetBitmask_, ARG_COUNT(__VA_ARGS__))(__VA_ARGS__)
#define GetBitmask_1(field) __getBitmask field
#define __getBitmask(name, value) BitMask(concat(name,_width), concat(name, _pos))
#define GetBitmask_2(field1, field2 ) GetBitmask_1(field1), GetBitmask_1(field2)
#define GetBitmask_3(field1, field2, field3 ) GetBitmask_1(field1), GetBitmask_2(field2, field3)
#define GetBitmask_4(field1, field2, field3, field4 ) GetBitmask_1(field1), GetBitmask_3(field2, field3, field4)
#define GetBitmask_5(field1, field2, field3, field4, field5 ) GetBitmask_1(field1), GetBitmask_4(field2, field3, field4, field5)
#define GetBitmask_6(field1, field2, field3, field4, field5, field6 ) GetBitmask_1(field1), GetBitmask_5(field2, field2, field3, field4, field5, field6)
#define GetBitmask_7(field1, field2, field3, field4, field5, field6, field7 ) GetBitmask_1(field1), GetBitmask_6(field2, field2, field3, field4, field5, field6, field7)

#endif
