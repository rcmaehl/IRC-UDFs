#include-once

; #INDEX# =======================================================================================================================
; Title .........: IRC_Constants
; AutoIt Version : 3.3.14.0
; Language ......: English
; Description ...: Constants to be included when using IRC functions. Based on: https://www.alien.net.au/irc/irc2numerics.html
; Author(s) .....: rcmaehl
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $RPL_WELCOME = 001
Global Const $RPL_YOURHOST = 002
Global Const $RPL_CREATED = 003
Global Const $RPL_MYINFO = 004
Global Const $RPL_BOUNCE = 005
Global Const $RPL_TRACELINK = 200
Global Const $RPL_TRACECONNECTING = 201
Global Const $RPL_TRACEHANDSHAKE = 202
Global Const $RPL_TRACEUNKNOWN = 203
Global Const $RPL_TRACEOPERATOR = 204
Global Const $RPL_TRACEUSER = 205
Global Const $RPL_TRACESERVER = 206
Global Const $RPL_TRACESERVICE = 207
Global Const $RPL_TRACENEWTYPE = 208
Global Const $RPL_TRACECLASS = 209
Global Const $RPL_TRACERECONNECT = 210
Global Const $RPL_STATSLINKINFO = 211
Global Const $RPL_STATSCOMMANDS = 212
Global Const $RPL_STATSCLINE = 213
Global Const $RPL_STATSNLINE = 214
Global Const $RPL_STATSILINE = 215
Global Const $RPL_STATSKLINE = 216
Global Const $RPL_STATSQLINE = 217
Global Const $RPL_STATSYLINE = 218
Global Const $RPL_ENDOFSTATS = 219
Global Const $RPL_UMODEIS = 221
Global Const $RPL_SERVICEINFO = 231
Global Const $RPL_ENDOFSERVICES = 232
Global Const $RPL_SERVICE = 233
Global Const $RPL_SERVLIST = 234
Global Const $RPL_SERVLISTEND = 235
Global Const $RPL_STATSVLINE = 240
Global Const $RPL_STATSLLINE = 241
Global Const $RPL_STATSUPTIME = 242
Global Const $RPL_STATSOLINE = 243
Global Const $RPL_STATSHLINE = 244
Global Const $RPL_STATSPING = 246
Global Const $RPL_STATSBLINE = 247
Global Const $RPL_STATSDLINE = 250

Global Const $RPL_TOPIC	= 332
Global Const $RPL_TOPICWHOTIME = 333

Global Const $RPL_NAMREPLY = 353

Global Const $RPL_ENDOFNAMES = 366

Global Const $ERR_NICKNAMEINUSE = 433
Global Const $ERR_UNAVAILRESOURCE = 437

; _IRCSendMsg Globals
; Message Type
Global Const $MSG_TRIM = 1
Global Const $MSG_PRIVMSG = 2
Global Const $MSG_NOTICE = 4
; Message Formatting
Global Const $MSG_BOLD = ChrW(2)
Global Const $MSG_UNDERLINE = ChrW(31)
Global Const $MSG_ITALIC = ChrW(29)
Global Const $MSG_RESET = ChrW(15)
; Message Colors
Global Const $MSG_WHITE = ChrW(3) & "0"
Global Const $MSG_BLACK = ChrW(3) & "1"
Global Const $MSG_BLUE = ChrW(3) & "2"
Global Const $MSG_GREEN = ChrW(3) & "3"
Global Const $MSG_LIGHTRED = ChrW(3) & "4"
Global Const $MSG_BROWN = ChrW(3) & "5"
Global Const $MSG_PURPLE = ChrW(3) & "6"
Global Const $MSG_ORANGE = ChrW(3) & "7"
Global Const $MSG_YELLOW = ChrW(3) & "8"
Global Const $MSG_LIGHTGREEN = ChrW(3) & "9"
Global Const $MSG_CYAN = ChrW(3) & "10"
Global Const $MSG_LIGHTCYAN = ChrW(3) & "11"
Global Const $MSG_LIGHTBLUE = ChrW(3) & "12"
Global Const $MSG_PINK = ChrW(3) & "13"
Global Const $MSG_GRAY = ChrW(3) & "14"
Global Const $MSG_LIGHTGRAY = ChrW(3) & "15"

; _IRCStripSpecial Globals
Global Const $RM_FORMAT = 1
Global Const $RM_COLOR = 2
Global Const $RM_CTCP = 4
; ===============================================================================================================================
