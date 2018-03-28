//	Copyright (c) 2009 Stephen Deken
//	All rights reserved.
// 
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	*	Redistributions of source code must retain the above copyright notice, this
//		list of conditions and the following disclaimer.
//	*	Redistributions in binary form must reproduce the above copyright notice,
//		this list of conditions and the following disclaimer in the documentation
//		and/or other materials provided with the distribution.
//	*	Neither the name KeyCastr nor the names of its contributors may be used to
//		endorse or promote products derived from this software without specific
//		prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#import "KCKeystroke.h"
#import "KCKeystrokeTransformer.h"

@implementation KCKeystroke

@synthesize keyCode = _keyCode, modifiers = _modifiers, charactersIgnoringModifiers = _charactersIgnoringModifiers;

- (id)initWithKeyCode:(uint16_t)keyCode modifiers:(uint32_t)modifiers charactersIgnoringModifiers:(NSString *)charactersIgnoringModifiers {
	if (!(self = [super init]))
		return nil;

	_keyCode = keyCode;
	_modifiers = modifiers;
	_charactersIgnoringModifiers = [charactersIgnoringModifiers copy];

	return self;
}

- (void)dealloc {
	[_charactersIgnoringModifiers release];
	_charactersIgnoringModifiers = nil;
	[super dealloc];
}

-(BOOL) isCommand
{
    // It would be better to updated the callin code to use `isReturn`.
    // Doing it here makes it centralized though.
    return (_modifiers & (NSAlternateKeyMask | NSControlKeyMask | NSCommandKeyMask)) != 0 || [self isReturn];
}

-(BOOL) isReturn
{
    return _keyCode == 36;
}

-(NSString*) convertToString
{
	return [[KCKeystrokeTransformer sharedTransformer] transformedValue:self];
}

@end
