IRC-UDFs
========

AutoIt IRC UDFs, UDFs to connect to IRC using TCP Functions, as well as perform actions once connected.

Permanent Installation Instructions:

    1. Unzip
    2a. Open All Examples Files in SciTE
    2b. Search -> Replace
        Set find what: #include "..\includes\IRC.au3"
        Set replace with: #include <IRC.au3>
        Choose Replace in Buffers
    3. Merge Examples folder with AutoIt3\Examples in Program Files
    4. Merge Includes folder with AutoIt3\Include in Program Files
    5. (OPTIONAL) Use a Client from Clients folder as your main IRC Client!

Notes:

    Originally created by Chip. 
    UDF Headers Updated compared to old script.  
    Error and Parameter Handling Update compared to old script.  
    If you need to bypass the RFC compliance of this UDF, use _IRCRaw.  
    These commands should work on every server following either RFC 1459 (legacy) or RFC 2812 (preferred).  
    The majority of the old functions have been modified. It will break most, if not all, scripts using the old UDF.  

Additional Milestones: 

    IRC Client (In the works)
        Config File
        GUI Example
        Multiple Networks At Once

Last Commit Shared with AutoIt Forums:

    02a6444eecf9fb4ea993eb788e8b64b30745cc34
