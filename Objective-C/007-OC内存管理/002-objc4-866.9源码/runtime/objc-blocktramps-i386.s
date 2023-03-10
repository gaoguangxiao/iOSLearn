/*
 * Copyright (c) 1999-2007 Apple Inc.  All Rights Reserved.
 * 
 * @APPLE_LICENSE_HEADER_START@
 * 
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this
 * file.
 * 
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 * 
 * @APPLE_LICENSE_HEADER_END@
 */

#ifdef __i386__

#include "objc-vm.h"

.text
.globl __objc_blockTrampolineImpl
.globl __objc_blockTrampolineStart
.globl __objc_blockTrampolineLast

.align 12 /* PAGE_SHIFT */
__objc_blockTrampolineImpl:
    movl (%esp), %eax  // return address pushed by trampoline
    //   4(%esp) is return address pushed by the call site
    movl 8(%esp), %ecx // self -> ecx
    movl %ecx, 12(%esp) // ecx -> _cmd
    movl -2*4096/*PAGE_SIZE */-5(%eax), %ecx // block object pointer -> ecx
                       // trampoline is -5 bytes from the return address
                       // data is -2 pages from the trampoline
    movl %ecx, 8(%esp) // ecx -> self
    ret                // back to TrampolineEntry to preserve CPU's return stack

.macro TrampolineEntry
    // This trampoline is 8 bytes long.
    // This callq is 5 bytes long.
    calll __objc_blockTrampolineImpl
    jmp  *12(%ecx)     // tail call block->invoke
.endmacro

.align 5
__objc_blockTrampolineStart:
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
    TrampolineEntry
__objc_blockTrampolineLast:
    TrampolineEntry


.text
.globl __objc_blockTrampolineImpl_stret
.globl __objc_blockTrampolineStart_stret
.globl __objc_blockTrampolineLast_stret

.align 12 /* PAGE_SHIFT */
__objc_blockTrampolineImpl_stret:
    movl (%esp), %eax  // return address pushed by trampoline
    //   4(%esp) is return address pushed by the call site
    //   8(%esp) is struct-return address
    movl 12(%esp), %ecx // self -> ecx
    movl %ecx, 16(%esp) // ecx -> _cmd
    movl -3*4096/*PAGE_SIZE*/-5(%eax), %ecx // block object pointer -> ecx
                       // trampoline is -5 bytes from the return address
                       // data is -3 pages from the trampoline
    movl %ecx, 12(%esp) // ecx -> self
    ret

.macro TrampolineEntry_stret
    // This trampoline is 8 bytes long.
    // This callq is 5 bytes long.
    call __objc_blockTrampolineImpl_stret
    jmp  *12(%ecx) // tail to block->invoke
.endmacro

.align 5
__objc_blockTrampolineStart_stret:
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
    TrampolineEntry_stret
__objc_blockTrampolineLast_stret:
    TrampolineEntry_stret

#endif
