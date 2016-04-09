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

Global Const $RM_FORMAT = 1
Global Const $RM_COLOR = 2
Global Const $RM_CTCP = 4
; ===============================================================================================================================
