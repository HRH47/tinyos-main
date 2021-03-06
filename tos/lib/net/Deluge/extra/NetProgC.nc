/*
 * Copyright (c) 2000-2005 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright (c) 2007 Johns Hopkins University.
 * All rights reserved.
 *
 */

/**
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 * @author Chieh-Jan Mike Liang <cliang4@cs.jhu.edu>
 * @author Razvan Musaloiu-E. <razvanm@cs.jhu.edu>
 */

includes NetProg;
includes TOSBoot;

configuration NetProgC {
  provides {
    interface NetProg;
  }
}

implementation {

  components MainC, InternalFlashC as IFlash, CrcC;
  components NetProgM, ReprogramGuardC;

  NetProg = NetProgM;

  MainC.SoftwareInit -> NetProgM.Init;
  NetProgM.IFlash -> IFlash;
  NetProgM.Crc -> CrcC;
  NetProgM.ReprogramGuard -> ReprogramGuardC;

  components LedsC;
  NetProgM.Leds -> LedsC;
  
  components ActiveMessageAddressC;
  NetProgM.initAmAddress -> ActiveMessageAddressC;

#if !defined(PLATFORM_TINYNODE) && !defined(PLATFORM_MULLE)
  components CC2420ControlP;
  NetProgM.CC2420Config -> CC2420ControlP;
#endif
}
