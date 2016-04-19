#include-once

; #INDEX# =======================================================================================================================
; Title .........: IRC_Constants
; AutoIt Version : 3.3.14.0
; Language ......: English
; Description ...: Constants to be included when using IRC functions. Based on: http://defs.ircdocs.horse/defs/numerics.html
; Author(s) .....: rcmaehl
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $RPL_WELCOME = 001	; RFC2812
Global Const $RPL_YOURHOST = 002	; RFC2812
Global Const $RPL_CREATED = 003	; RFC2812
Global Const $RPL_MYINFO = 004	; RFC2812
Global Const $RPL_BOUNCE = 005	; RFC2812
Global Const $RPL_ISUPPORT = 005
Global Const $RPL_MAP = 006	; Unreal
Global Const $RPL_MAPEND = 007	; Unreal
Global Const $RPL_SNOMASK = 008	; ircu
Global Const $RPL_STATMEMTOT = 009	; ircu
Global Const $RPL_BOUNCE_ALT = 010
Global Const $RPL_STATMEM = 010	; ircu
Global Const $RPL_YOURCOOKIE = 014	; Hybrid?
Global Const $RPL_MAP_ALT = 015	; ircu
Global Const $RPL_MAPMORE = 016	; ircu
Global Const $RPL_MAPEND_ALT = 017	; ircu
Global Const $RPL_HELLO = 020	; rusnet-ircd
Global Const $RPL_APASSWARN_SET = 030	; ircu
Global Const $RPL_APASSWARN_SECRET = 031	; ircu
Global Const $RPL_APASSWARN_CLEAR = 032	; ircu
Global Const $RPL_YOURID = 042	; IRCnet
Global Const $RPL_SAVENICK = 043	; IRCnet
Global Const $RPL_ATTEMPTINGJUNC = 050	; aircd
Global Const $RPL_ATTEMPTINGREROUTE = 051	; aircd
Global Const $RPL_REMOTEISUPPORT = 105	; Unreal
Global Const $RPL_TRACELINK = 200	; RFC1459
Global Const $RPL_TRACECONNECTING = 201	; RFC1459
Global Const $RPL_TRACEHANDSHAKE = 202	; RFC1459
Global Const $RPL_TRACEUNKNOWN = 203	; RFC1459
Global Const $RPL_TRACEOPERATOR = 204	; RFC1459
Global Const $RPL_TRACEUSER = 205	; RFC1459
Global Const $RPL_TRACESERVER = 206	; RFC1459
Global Const $RPL_TRACESERVICE = 207	; RFC2812
Global Const $RPL_TRACENEWTYPE = 208	; RFC1459
Global Const $RPL_TRACECLASS = 209	; RFC2812
Global Const $RPL_TRACERECONNECT = 210	; RFC2812
Global Const $RPL_STATS = 210	; aircd
Global Const $RPL_STATSHELP = 210	; Unreal
Global Const $RPL_STATSLINKINFO = 211	; RFC1459
Global Const $RPL_STATSCOMMANDS = 212	; RFC1459
Global Const $RPL_STATSCLINE = 213	; RFC1459
Global Const $RPL_STATSNLINE = 214	; RFC1459
Global Const $RPL_STATSILINE = 215	; RFC1459
Global Const $RPL_STATSKLINE = 216	; RFC1459
Global Const $RPL_STATSQLINE = 217	; RFC1459
Global Const $RPL_STATSPLINE = 217	; ircu
Global Const $RPL_STATSYLINE = 218	; RFC1459
Global Const $RPL_ENDOFSTATS = 219	; RFC1459
Global Const $RPL_STATSPLINE_ALT = 220	; Hybrid
Global Const $RPL_STATSBLINE = 220	; Bahamut, Unreal
Global Const $RPL_STATSWLINE = 220	; Nefarious
Global Const $RPL_UMODEIS = 221	; RFC1459
Global Const $RPL_MODLIST = 222
Global Const $RPL_SQLINE_NICK = 222	; Unreal
Global Const $RPL_STATSBLINE_ALT = 222	; Bahamut
Global Const $RPL_STATSJLINE = 222	; ircu
Global Const $RPL_CODEPAGE = 222	; rusnet-ircd
Global Const $RPL_STATSELINE = 223	; Bahamut
Global Const $RPL_STATSGLINE = 223	; Unreal
Global Const $RPL_CHARSET = 223	; rusnet-ircd
Global Const $RPL_STATSFLINE = 224	; Hybrid, Bahamut
Global Const $RPL_STATSTLINE = 224	; Unreal
Global Const $RPL_STATSDLINE = 225	; Hybrid
Global Const $RPL_STATSZLINE = 225	; Bahamut
Global Const $RPL_STATSELINE_ALT = 225	; Unreal
Global Const $RPL_STATSCOUNT = 226	; Bahamut
Global Const $RPL_STATSALINE = 226	; Hybrid
Global Const $RPL_STATSNLINE_ALT = 226	; Unreal
Global Const $RPL_STATSGLINE_ALT = 227	; Bahamut
Global Const $RPL_STATSVLINE = 227	; Unreal
Global Const $RPL_STATSBLINE_ALT2 = 227	; Rizon
Global Const $RPL_STATSQLINE_ALT = 228	; ircu
Global Const $RPL_STATSBANVER = 228	; Unreal
Global Const $RPL_STATSSPAMF = 229	; Unreal
Global Const $RPL_STATSEXCEPTTKL = 230	; Unreal
Global Const $RPL_SERVICEINFO = 231	; RFC1459
Global Const $RPL_ENDOFSERVICES = 232	; RFC1459
Global Const $RPL_RULES = 232	; Unreal
Global Const $RPL_SERVICE = 233	; RFC1459
Global Const $RPL_SERVLIST = 234	; RFC2812
Global Const $RPL_SERVLISTEND = 235	; RFC2812
Global Const $RPL_STATSVERBOSE = 236	; ircu
Global Const $RPL_STATSENGINE = 237	; ircu
Global Const $RPL_STATSFLINE_ALT = 238	; ircu
Global Const $RPL_STATSIAUTH = 239	; IRCnet
Global Const $RPL_STATSVLINE_ALT = 240	; RFC2812
Global Const $RPL_STATSXLINE = 240	; AustHex
Global Const $RPL_STATSLLINE = 241	; RFC1459
Global Const $RPL_STATSUPTIME = 242	; RFC1459
Global Const $RPL_STATSOLINE = 243	; RFC1459
Global Const $RPL_STATSHLINE = 244	; RFC1459
Global Const $RPL_STATSSLINE = 245	; Bahamut, IRCnet, Hybrid
Global Const $RPL_STATSTLINE_ALT = 245	; Hybrid?
Global Const $RPL_STATSPING = 246	; RFC2812
Global Const $RPL_STATSSERVICE = 246	; Hybrid
Global Const $RPL_STATSTLINE_ALT2 = 246	; ircu
Global Const $RPL_STATSULINE = 246	; Hybrid
Global Const $RPL_STATSBLINE_ALT3 = 247	; RFC2812
Global Const $RPL_STATSXLINE_ALT = 247	; Hybrid, PTlink, Unreal
Global Const $RPL_STATSGLINE_ALT2 = 247	; ircu
Global Const $RPL_STATSULINE_ALT = 248	; ircu
Global Const $RPL_STATSDEFINE = 248	; IRCnet
Global Const $RPL_STATSULINE_ALT2 = 249
Global Const $RPL_STATSDEBUG = 249	; Hybrid
Global Const $RPL_STATSDLINE_ALT = 250	; RFC2812
Global Const $RPL_STATSCONN = 250	; ircu, Unreal
Global Const $RPL_LUSERCLIENT = 251	; RFC1459
Global Const $RPL_LUSEROP = 252	; RFC1459
Global Const $RPL_LUSERUNKNOWN = 253	; RFC1459
Global Const $RPL_LUSERCHANNELS = 254	; RFC1459
Global Const $RPL_LUSERME = 255	; RFC1459
Global Const $RPL_ADMINME = 256	; RFC1459
Global Const $RPL_ADMINLOC1 = 257	; RFC1459
Global Const $RPL_ADMINLOC2 = 258	; RFC1459
Global Const $RPL_ADMINEMAIL = 259	; RFC1459
Global Const $RPL_TRACELOG = 261	; RFC1459
Global Const $RPL_TRACEPING = 262
Global Const $RPL_TRACEEND = 262	; RFC2812
Global Const $RPL_TRYAGAIN = 263	; RFC2812
Global Const $RPL_USINGSSL = 264	; rusnet-ircd
Global Const $RPL_LOCALUSERS = 265	; aircd, Hybrid, Bahamut
Global Const $RPL_GLOBALUSERS = 266	; aircd, Hybrid, Bahamut
Global Const $RPL_START_NETSTAT = 267	; aircd
Global Const $RPL_NETSTAT = 268	; aircd
Global Const $RPL_END_NETSTAT = 269	; aircd
Global Const $RPL_PRIVS = 270	; ircu
Global Const $RPL_MAPUSERS = 270	; InspIRCd
Global Const $RPL_SILELIST = 271	; ircu
Global Const $RPL_ENDOFSILELIST = 272	; ircu
Global Const $RPL_NOTIFY = 273	; aircd
Global Const $RPL_ENDNOTIFY = 274	; aircd
Global Const $RPL_STATSDELTA = 274	; IRCnet
Global Const $RPL_STATSDLINE_ALT2 = 275	; ircu, Ultimate
Global Const $RPL_WHOISCERTFP = 276	; oftc-hybrid
Global Const $RPL_STATSRLINE = 276	; ircu
Global Const $RPL_VCHANEXIST = 276	; Hybrid
Global Const $RPL_VCHANLIST = 277	; Hybrid
Global Const $RPL_VCHANHELP = 278	; Hybrid 7.0?
Global Const $RPL_GLIST = 280	; ircu
Global Const $RPL_ENDOFGLIST = 281	; ircu
Global Const $RPL_ACCEPTLIST = 281
Global Const $RPL_ENDOFACCEPT = 282
Global Const $RPL_JUPELIST = 282	; ircu
Global Const $RPL_ALIST = 283
Global Const $RPL_ENDOFJUPELIST = 283	; ircu
Global Const $RPL_ENDOFALIST = 284
Global Const $RPL_FEATURE = 284	; ircu
Global Const $RPL_GLIST_HASH = 285
Global Const $RPL_CHANINFO_HANDLE = 285	; aircd
Global Const $RPL_NEWHOSTIS = 285	; QuakeNet
Global Const $RPL_CHANINFO_USERS = 286	; aircd
Global Const $RPL_CHKHEAD = 286	; QuakeNet
Global Const $RPL_CHANINFO_CHOPS = 287	; aircd
Global Const $RPL_CHANUSER = 287	; QuakeNet
Global Const $RPL_CHANINFO_VOICES = 288	; aircd
Global Const $RPL_PATCHHEAD = 288	; QuakeNet
Global Const $RPL_CHANINFO_AWAY = 289	; aircd
Global Const $RPL_PATCHCON = 289	; QuakeNet
Global Const $RPL_CHANINFO_OPERS = 290	; aircd
Global Const $RPL_HELPHDR = 290	; Unreal
Global Const $RPL_DATASTR = 290	; QuakeNet
Global Const $RPL_CHANINFO_BANNED = 291	; aircd
Global Const $RPL_HELPOP = 291	; Unreal
Global Const $RPL_ENDOFCHECK = 291	; QuakeNet
Global Const $RPL_CHANINFO_BANS = 292	; aircd
Global Const $RPL_HELPTLR = 292	; Unreal
Global Const $ERR_SEARCHNOMATCH = 292	; Nefarious
Global Const $RPL_CHANINFO_INVITE = 293	; aircd
Global Const $RPL_HELPHLP = 293	; Unreal
Global Const $RPL_CHANINFO_INVITES = 294	; aircd
Global Const $RPL_HELPFWD = 294	; Unreal
Global Const $RPL_CHANINFO_KICK = 295	; aircd
Global Const $RPL_HELPIGN = 295	; Unreal
Global Const $RPL_CHANINFO_KICKS = 296	; aircd
Global Const $RPL_END_CHANINFO = 299	; aircd
Global Const $RPL_NONE = 300	; RFC1459
Global Const $RPL_AWAY = 301	; RFC1459
Global Const $RPL_USERHOST = 302	; RFC1459
Global Const $RPL_ISON = 303	; RFC1459
Global Const $RPL_TEXT = 304	; irc2?
Global Const $RPL_SYNTAX = 304	; InspIRCd
Global Const $RPL_UNAWAY = 305	; RFC1459
Global Const $RPL_NOWAWAY = 306	; RFC1459
Global Const $RPL_USERIP = 307
Global Const $RPL_WHOISREGNICK = 307	; Bahamut, Unreal
Global Const $RPL_SUSERHOST = 307	; AustHex
Global Const $RPL_NOTIFYACTION = 308	; aircd
Global Const $RPL_WHOISADMIN = 308	; Bahamut
Global Const $RPL_RULESSTART = 308	; Unreal
Global Const $RPL_NICKTRACE = 309	; aircd
Global Const $RPL_WHOISSADMIN = 309	; Bahamut
Global Const $RPL_ENDOFRULES = 309	; Unreal
Global Const $RPL_WHOISHELPER = 309	; AustHex
Global Const $RPL_WHOISSVCMSG = 310	; Bahamut
Global Const $RPL_WHOISHELPOP = 310	; Unreal
Global Const $RPL_WHOISSERVICE = 310	; AustHex
Global Const $RPL_WHOISUSER = 311	; RFC1459
Global Const $RPL_WHOISSERVER = 312	; RFC1459
Global Const $RPL_WHOISOPERATOR = 313	; RFC1459
Global Const $RPL_WHOWASUSER = 314	; RFC1459
Global Const $RPL_ENDOFWHO = 315	; RFC1459
Global Const $RPL_WHOISPRIVDEAF = 316	; Nefarious
Global Const $RPL_WHOISCHANOP = 316	; RFC1459
Global Const $RPL_WHOISIDLE = 317	; RFC1459
Global Const $RPL_ENDOFWHOIS = 318	; RFC1459
Global Const $RPL_WHOISCHANNELS = 319	; RFC1459
Global Const $RPL_WHOISVIRT = 320	; AustHex
Global Const $RPL_WHOIS_HIDDEN = 320	; Anothernet
Global Const $RPL_WHOISSPECIAL = 320	; Unreal
Global Const $RPL_LISTSTART = 321	; RFC1459
Global Const $RPL_LIST = 322	; RFC1459
Global Const $RPL_LISTEND = 323	; RFC1459
Global Const $RPL_CHANNELMODEIS = 324	; RFC1459
Global Const $RPL_UNIQOPIS = 325	; RFC2812
Global Const $RPL_CHANNELPASSIS = 325
Global Const $RPL_WHOISWEBIRC = 325	; Nefarious
Global Const $RPL_CHANNELMLOCKIS = 325	; sorircd
Global Const $RPL_NOCHANPASS = 326
Global Const $RPL_CHPASSUNKNOWN = 327
Global Const $RPL_WHOISHOST = 327	; rusnet-ircd
Global Const $RPL_CHANNEL_URL = 328	; Bahamut, AustHex
Global Const $RPL_CREATIONTIME = 329	; Bahamut
Global Const $RPL_WHOWAS_TIME = 330
Global Const $RPL_WHOISACCOUNT = 330	; ircu
Global Const $RPL_NOTOPIC = 331	; RFC1459
Global Const $RPL_TOPIC = 332	; RFC1459
Global Const $RPL_TOPICWHOTIME = 333	; ircu
Global Const $RPL_LISTUSAGE = 334	; ircu
Global Const $RPL_COMMANDSYNTAX = 334	; Bahamut
Global Const $RPL_LISTSYNTAX = 334	; Unreal
Global Const $RPL_WHOISBOT = 335	; Unreal
Global Const $RPL_WHOISTEXT = 335	; Hybrid
Global Const $RPL_WHOISACCOUNTONLY = 335	; Nefarious
Global Const $RPL_INVITELIST = 336	; Hybrid
Global Const $RPL_WHOISBOT_ALT = 336	; Nefarious
Global Const $RPL_ENDOFINVITELIST = 337	; Hybrid
Global Const $RPL_WHOISTEXT_ALT = 337	; Hybrid?
Global Const $RPL_CHANPASSOK = 338
Global Const $RPL_WHOISACTUALLY = 338	; ircu, Bahamut
Global Const $RPL_BADCHANPASS = 339
Global Const $RPL_WHOISMARKS = 339	; Nefarious
Global Const $RPL_USERIP_ALT = 340	; ircu
Global Const $RPL_INVITING = 341	; RFC1459
Global Const $RPL_SUMMONING = 342	; RFC1459
Global Const $RPL_WHOISKILL = 343	; Nefarious
Global Const $RPL_INVITED = 345	; GameSurge
Global Const $RPL_INVITELIST_ALT = 346	; RFC2812
Global Const $RPL_ENDOFINVITELIST_ALT = 347	; RFC2812
Global Const $RPL_EXCEPTLIST = 348	; RFC2812
Global Const $RPL_ENDOFEXCEPTLIST = 349	; RFC2812
Global Const $RPL_VERSION = 351	; RFC1459
Global Const $RPL_WHOREPLY = 352	; RFC1459
Global Const $RPL_NAMREPLY = 353	; RFC1459
Global Const $RPL_WHOSPCRPL = 354	; ircu
Global Const $RPL_NAMREPLY_ = 355	; QuakeNet
Global Const $RPL_MAP_ALT2 = 357	; AustHex
Global Const $RPL_MAPMORE_ALT = 358	; AustHex
Global Const $RPL_MAPEND_ALT2 = 359	; AustHex
Global Const $RPL_WHOWASREAL = 360	; Charybdis
Global Const $RPL_KILLDONE = 361	; RFC1459
Global Const $RPL_CLOSING = 362	; RFC1459
Global Const $RPL_CLOSEEND = 363	; RFC1459
Global Const $RPL_LINKS = 364	; RFC1459
Global Const $RPL_ENDOFLINKS = 365	; RFC1459
Global Const $RPL_ENDOFNAMES = 366	; RFC1459
Global Const $RPL_BANLIST = 367	; RFC1459
Global Const $RPL_ENDOFBANLIST = 368	; RFC1459
Global Const $RPL_ENDOFWHOWAS = 369	; RFC1459
Global Const $RPL_INFO = 371	; RFC1459
Global Const $RPL_MOTD = 372	; RFC1459
Global Const $RPL_INFOSTART = 373	; RFC1459
Global Const $RPL_ENDOFINFO = 374	; RFC1459
Global Const $RPL_MOTDSTART = 375	; RFC1459
Global Const $RPL_ENDOFMOTD = 376	; RFC1459
Global Const $RPL_KICKEXPIRED = 377	; aircd
Global Const $RPL_SPAM = 377	; AustHex
Global Const $RPL_BANEXPIRED = 378	; aircd
Global Const $RPL_WHOISHOST_ALT = 378	; Unreal
Global Const $RPL_MOTD_ALT = 378	; AustHex
Global Const $RPL_KICKLINKED = 379	; aircd
Global Const $RPL_WHOISMODES = 379	; Unreal
Global Const $RPL_WHOWASIP = 379	; InspIRCd
Global Const $RPL_BANLINKED = 380	; aircd
Global Const $RPL_YOURHELPER = 380	; AustHex
Global Const $RPL_YOUREOPER = 381	; RFC1459
Global Const $RPL_REHASHING = 382	; RFC1459
Global Const $RPL_YOURESERVICE = 383	; RFC2812
Global Const $RPL_MYPORTIS = 384	; RFC1459
Global Const $RPL_NOTOPERANYMORE = 385	; AustHex, Hybrid, Unreal
Global Const $RPL_QLIST = 386	; Unreal
Global Const $RPL_IRCOPS = 386	; Ultimate
Global Const $RPL_IRCOPSHEADER = 386	; Nefarious
Global Const $RPL_RSACHALLENGE = 386	; Hybrid
Global Const $RPL_ENDOFQLIST = 387	; Unreal
Global Const $RPL_ENDOFIRCOPS = 387	; Ultimate
Global Const $RPL_IRCOPS_ALT = 387	; Nefarious
Global Const $RPL_ALIST_ALT = 388	; Unreal
Global Const $RPL_ENDOFIRCOPS_ALT = 388	; Nefarious
Global Const $RPL_ENDOFALIST_ALT = 389	; Unreal
Global Const $RPL_TIME = 391	; RFC1459
Global Const $RPL_TIME2 = 391	; ircu
Global Const $RPL_TIME_ALT = 391	; bdq-ircd
Global Const $RPL_TIME_ALT2 = 391
Global Const $RPL_USERSSTART = 392	; RFC1459
Global Const $RPL_USERS = 393	; RFC1459
Global Const $RPL_ENDOFUSERS = 394	; RFC1459
Global Const $RPL_NOUSERS = 395	; RFC1459
Global Const $RPL_HOSTHIDDEN = 396	; Undernet
Global Const $RPL_VISIBLEHOST = 396	; Hybrid
Global Const $ERR_UNKNOWNERROR = 400
Global Const $ERR_NOSUCHNICK = 401	; RFC1459
Global Const $ERR_NOSUCHSERVER = 402	; RFC1459
Global Const $ERR_NOSUCHCHANNEL = 403	; RFC1459
Global Const $ERR_CANNOTSENDTOCHAN = 404	; RFC1459
Global Const $ERR_TOOMANYCHANNELS = 405	; RFC1459
Global Const $ERR_WASNOSUCHNICK = 406	; RFC1459
Global Const $ERR_TOOMANYTARGETS = 407	; RFC1459
Global Const $ERR_NOSUCHSERVICE = 408	; RFC2812
Global Const $ERR_NOCOLORSONCHAN = 408	; Bahamut
Global Const $ERR_NOCTRLSONCHAN = 408	; Hybrid
Global Const $ERR_NOORIGIN = 409	; RFC1459
Global Const $ERR_INVALIDCAPCMD = 410	; Undernet?
Global Const $ERR_NORECIPIENT = 411	; RFC1459
Global Const $ERR_NOTEXTTOSEND = 412	; RFC1459
Global Const $ERR_NOTOPLEVEL = 413	; RFC1459
Global Const $ERR_WILDTOPLEVEL = 414	; RFC1459
Global Const $ERR_BADMASK = 415	; RFC2812
Global Const $ERR_TOOMANYMATCHES = 416	; IRCnet
Global Const $ERR_QUERYTOOLONG = 416	; ircu
Global Const $ERR_INPUTTOOLONG = 417	; ircu
Global Const $ERR_LENGTHTRUNCATED = 419	; aircd
Global Const $ERR_UNKNOWNCOMMAND = 421	; RFC1459
Global Const $ERR_NOMOTD = 422	; RFC1459
Global Const $ERR_NOADMININFO = 423	; RFC1459
Global Const $ERR_FILEERROR = 424	; RFC1459
Global Const $ERR_NOOPERMOTD = 425	; Unreal
Global Const $ERR_TOOMANYAWAY = 429	; Bahamut
Global Const $ERR_EVENTNICKCHANGE = 430	; AustHex
Global Const $ERR_NONICKNAMEGIVEN = 431	; RFC1459
Global Const $ERR_ERRONEUSNICKNAME = 432	; RFC1459
Global Const $ERR_NICKNAMEINUSE = 433	; RFC1459
Global Const $ERR_SERVICENAMEINUSE = 434	; AustHex?
Global Const $ERR_NORULES = 434	; Unreal, Ultimate
Global Const $ERR_SERVICECONFUSED = 435	; Unreal
Global Const $ERR_BANONCHAN = 435	; Bahamut
Global Const $ERR_NICKCOLLISION = 436	; RFC1459
Global Const $ERR_UNAVAILRESOURCE = 437	; RFC2812
Global Const $ERR_BANNICKCHANGE = 437	; ircu
Global Const $ERR_NICKTOOFAST = 438	; ircu
Global Const $ERR_DEAD = 438	; IRCnet
Global Const $ERR_TARGETTOOFAST = 439	; ircu
Global Const $ERR_SERVICESDOWN = 440	; Bahamut, Unreal
Global Const $ERR_USERNOTINCHANNEL = 441	; RFC1459
Global Const $ERR_NOTONCHANNEL = 442	; RFC1459
Global Const $ERR_USERONCHANNEL = 443	; RFC1459
Global Const $ERR_NOLOGIN = 444	; RFC1459
Global Const $ERR_SUMMONDISABLED = 445	; RFC1459
Global Const $ERR_USERSDISABLED = 446	; RFC1459
Global Const $ERR_NONICKCHANGE = 447	; Unreal
Global Const $ERR_FORBIDDENCHANNEL = 448	; Unreal
Global Const $ERR_NOTIMPLEMENTED = 449	; Undernet
Global Const $ERR_NOTREGISTERED = 451	; RFC1459
Global Const $ERR_IDCOLLISION = 452
Global Const $ERR_NICKLOST = 453
Global Const $ERR_HOSTILENAME = 455	; Unreal
Global Const $ERR_ACCEPTFULL = 456
Global Const $ERR_ACCEPTEXIST = 457
Global Const $ERR_ACCEPTNOT = 458
Global Const $ERR_NOHIDING = 459	; Unreal
Global Const $ERR_NOTFORHALFOPS = 460	; Unreal
Global Const $ERR_NEEDMOREPARAMS = 461	; RFC1459
Global Const $ERR_ALREADYREGISTERED = 462	; RFC1459
Global Const $ERR_NOPERMFORHOST = 463	; RFC1459
Global Const $ERR_PASSWDMISMATCH = 464	; RFC1459
Global Const $ERR_YOUREBANNEDCREEP = 465	; RFC1459
Global Const $ERR_YOUWILLBEBANNED = 466	; RFC1459
Global Const $ERR_KEYSET = 467	; RFC1459
Global Const $ERR_INVALIDUSERNAME = 468	; ircu
Global Const $ERR_ONLYSERVERSCANCHANGE = 468	; Bahamut, Unreal
Global Const $ERR_NOCODEPAGE = 468	; rusnet-ircd
Global Const $ERR_LINKSET = 469	; Unreal
Global Const $ERR_LINKCHANNEL = 470	; Unreal
Global Const $ERR_KICKEDFROMCHAN = 470	; aircd
Global Const $ERR_7BIT = 470	; rusnet-ircd
Global Const $ERR_CHANNELISFULL = 471	; RFC1459
Global Const $ERR_UNKNOWNMODE = 472	; RFC1459
Global Const $ERR_INVITEONLYCHAN = 473	; RFC1459
Global Const $ERR_BANNEDFROMCHAN = 474	; RFC1459
Global Const $ERR_BADCHANNELKEY = 475	; RFC1459
Global Const $ERR_BADCHANMASK = 476	; RFC2812
Global Const $ERR_NOCHANMODES = 477	; RFC2812
Global Const $ERR_NEEDREGGEDNICK = 477	; Bahamut, ircu, Unreal
Global Const $ERR_BANLISTFULL = 478	; RFC2812
Global Const $ERR_BADCHANNAME = 479	; Hybrid
Global Const $ERR_LINKFAIL = 479	; Unreal
Global Const $ERR_NOCOLOR = 479	; rusnet-ircd
Global Const $ERR_NOULINE = 480	; AustHex
Global Const $ERR_CANNOTKNOCK = 480	; Unreal
Global Const $ERR_THROTTLE = 480	; Ratbox
Global Const $ERR_SSLONLYCHAN = 480	; Hybrid
Global Const $ERR_NOWALLOP = 480	; rusnet-ircd
Global Const $ERR_NOPRIVILEGES = 481	; RFC1459
Global Const $ERR_CHANOPRIVSNEEDED = 482	; RFC1459
Global Const $ERR_CANTKILLSERVER = 483	; RFC1459
Global Const $ERR_RESTRICTED = 484	; RFC2812
Global Const $ERR_ISCHANSERVICE = 484	; Undernet
Global Const $ERR_DESYNC = 484	; Bahamut, Hybrid, PTlink
Global Const $ERR_ATTACKDENY = 484	; Unreal
Global Const $ERR_UNIQOPRIVSNEEDED = 485	; RFC2812
Global Const $ERR_KILLDENY = 485	; Unreal
Global Const $ERR_CANTKICKADMIN = 485	; PTlink
Global Const $ERR_ISREALSERVICE = 485	; QuakeNet
Global Const $ERR_CHANBANREASON = 485	; Hybrid
Global Const $ERR_BANNEDNICK = 485	; Ratbox
Global Const $ERR_NONONREG = 486	; Unreal?
Global Const $ERR_HTMDISABLED = 486	; Unreal
Global Const $ERR_ACCOUNTONLY = 486	; QuakeNet
Global Const $ERR_RLINED = 486	; rusnet-ircd
Global Const $ERR_CHANTOORECENT = 487	; IRCnet
Global Const $ERR_MSGSERVICES = 487	; Bahamut
Global Const $ERR_NOTFORUSERS = 487	; Unreal?
Global Const $ERR_TSLESSCHAN = 488	; IRCnet
Global Const $ERR_HTMDISABLED_ALT = 488	; Unreal?
Global Const $ERR_SECUREONLYCHAN = 489	; Unreal
Global Const $ERR_VOICENEEDED = 489	; Undernet
Global Const $ERR_ALLMUSTSSL = 490	; Unreal, apparently
Global Const $ERR_NOSWEAR = 490	; Unreal
Global Const $ERR_NOOPERHOST = 491	; RFC1459
Global Const $ERR_NOSERVICEHOST = 492	; RFC1459
Global Const $ERR_NOCTCP = 492	; Hybrid / Unreal?
Global Const $ERR_CANNOTSENDTOUSER = 492	; Charybdis?
Global Const $ERR_NOFEATURE = 493	; ircu
Global Const $ERR_BADFEATVALUE = 494	; ircu
Global Const $ERR_OWNMODE = 494	; Bahamut, charybdis?
Global Const $ERR_BADLOGTYPE = 495	; ircu
Global Const $ERR_DELAYREJOIN = 495	; InspIRCd
Global Const $ERR_BADLOGSYS = 496	; ircu
Global Const $ERR_BADLOGVALUE = 497	; ircu
Global Const $ERR_ISOPERLCHAN = 498	; ircu
Global Const $ERR_CHANOWNPRIVNEEDED = 499	; Unreal
Global Const $ERR_TOOMANYJOINS = 500	; Unreal?
Global Const $ERR_NOREHASHPARAM = 500	; rusnet-ircd
Global Const $ERR_UMODEUNKNOWNFLAG = 501	; RFC1459
Global Const $ERR_USERSDONTMATCH = 502	; RFC1459
Global Const $ERR_GHOSTEDCLIENT = 503	; Hybrid
Global Const $ERR_VWORLDWARN = 503	; AustHex
Global Const $ERR_USERNOTONSERV = 504
Global Const $ERR_SILELISTFULL = 511	; ircu
Global Const $ERR_TOOMANYWATCH = 512	; Bahamut
Global Const $ERR_NOSUCHGLINE = 512	; ircu
Global Const $ERR_BADPING = 513	; ircu
Global Const $ERR_TOOMANYDCC = 514	; Bahamut
Global Const $ERR_NOSUCHJUPE = 514	; irch
Global Const $ERR_INVALID_ERROR = 514	; ircu
Global Const $ERR_BADEXPIRE = 515	; ircu
Global Const $ERR_DONTCHEAT = 516	; ircu
Global Const $ERR_DISABLED = 517	; ircu
Global Const $ERR_NOINVITE = 518	; Unreal
Global Const $ERR_LONGMASK = 518	; ircu
Global Const $ERR_ADMONLY = 519	; Unreal
Global Const $ERR_TOOMANYUSERS = 519	; ircu
Global Const $ERR_OPERONLY = 520	; Unreal
Global Const $ERR_MASKTOOWIDE = 520	; ircu
Global Const $ERR_WHOTRUNC = 520	; AustHex
Global Const $ERR_LISTSYNTAX = 521	; Bahamut
Global Const $ERR_NOSUCHGLINE_ALT = 521	; Nefarious
Global Const $ERR_WHOSYNTAX = 522	; Bahamut
Global Const $ERR_WHOLIMEXCEED = 523	; Bahamut
Global Const $ERR_QUARANTINED = 524	; ircu
Global Const $ERR_OPERSPVERIFY = 524	; Unreal
Global Const $ERR_HELPNOTFOUND = 524	; Hybrid
Global Const $ERR_INVALIDKEY = 525	; ircu
Global Const $ERR_REMOTEPFX = 525	; CAPAB USERCMDPFX
Global Const $ERR_PFXUNROUTABLE = 526	; CAPAB USERCMDPFX
Global Const $ERR_CANTSENDTOUSER = 531	; InspIRCd
Global Const $ERR_BADHOSTMASK = 550	; QuakeNet
Global Const $ERR_HOSTUNAVAIL = 551	; QuakeNet
Global Const $ERR_USINGSLINE = 552	; QuakeNet
Global Const $ERR_STATSSLINE = 553	; QuakeNet
Global Const $ERR_NOTLOWEROPLEVEL = 560	; ircu
Global Const $ERR_NOTMANAGER = 561	; ircu
Global Const $ERR_CHANSECURED = 562	; ircu
Global Const $ERR_UPASSSET = 563	; ircu
Global Const $ERR_UPASSNOTSET = 564	; ircu
Global Const $ERR_NOMANAGER = 566	; ircu
Global Const $ERR_UPASS_SAME_APASS = 567	; ircu
Global Const $ERR_LASTERROR = 568	; ircu
Global Const $RPL_NOOMOTD = 568	; Nefarious
Global Const $RPL_REAWAY = 597	; Unreal
Global Const $RPL_GONEAWAY = 598	; Unreal
Global Const $RPL_NOTAWAY = 599	; Unreal
Global Const $RPL_LOGON = 600	; Bahamut, Unreal
Global Const $RPL_LOGOFF = 601	; Bahamut, Unreal
Global Const $RPL_WATCHOFF = 602	; Bahamut, Unreal
Global Const $RPL_WATCHSTAT = 603	; Bahamut, Unreal
Global Const $RPL_NOWON = 604	; Bahamut, Unreal
Global Const $RPL_NOWOFF = 605	; Bahamut, Unreal
Global Const $RPL_WATCHLIST = 606	; Bahamut, Unreal
Global Const $RPL_ENDOFWATCHLIST = 607	; Bahamut, Unreal
Global Const $RPL_WATCHCLEAR = 608	; Ultimate
Global Const $RPL_NOWISAWAY = 609	; Unreal
Global Const $RPL_MAPMORE_ALT2 = 610	; Unreal
Global Const $RPL_ISOPER = 610	; Ultimate
Global Const $RPL_ISLOCOP = 611	; Ultimate
Global Const $RPL_ISNOTOPER = 612	; Ultimate
Global Const $RPL_ENDOFISOPER = 613	; Ultimate
Global Const $RPL_MAPMORE_ALT3 = 615	; PTlink
Global Const $RPL_WHOISMODES_ALT = 615	; Ultimate
Global Const $RPL_WHOISHOST_ALT2 = 616	; Ultimate
Global Const $RPL_WHOISSSLFP = 617	; Nefarious
Global Const $RPL_DCCSTATUS = 617	; Bahamut
Global Const $RPL_WHOISBOT_ALT2 = 617	; Ultimate
Global Const $RPL_DCCLIST = 618	; Bahamut
Global Const $RPL_ENDOFDCCLIST = 619	; Bahamut
Global Const $RPL_WHOWASHOST = 619	; Ultimate
Global Const $RPL_DCCINFO = 620	; Bahamut
Global Const $RPL_RULESSTART_ALT = 620	; Ultimate
Global Const $RPL_RULES_ALT = 621	; Ultimate
Global Const $RPL_ENDOFRULES_ALT = 622	; Ultimate
Global Const $RPL_MAPMORE_ALT4 = 623	; Ultimate
Global Const $RPL_OMOTDSTART = 624	; Ultimate
Global Const $RPL_OMOTD = 625	; Ultimate
Global Const $RPL_ENDOFO = 626	; Ultimate
Global Const $RPL_SETTINGS = 630	; Ultimate
Global Const $RPL_ENDOFSETTINGS = 631	; Ultimate
Global Const $RPL_DUMPING = 640	; Unreal
Global Const $RPL_DUMPRPL = 641	; Unreal
Global Const $RPL_EODUMP = 642	; Unreal
Global Const $RPL_SPAMCMDFWD = 659	; Unreal
Global Const $RPL_STARTTLS = 670	; IRCv3
Global Const $RPL_WHOISSECURE = 671	; Unreal
Global Const $RPL_UNKNOWNMODES = 672	; Ithildin
Global Const $RPL_WHOISREALIP = 672	; Rizon
Global Const $RPL_CANNOTSETMODES = 673	; Ithildin
Global Const $ERR_STARTTLS = 691	; IRCv3
Global Const $RPL_MODLIST_ALT = 702	; RatBox
Global Const $RPL_COMMANDS = 702	; InspIRCd
Global Const $RPL_ENDOFMODLIST = 703	; RatBox
Global Const $RPL_COMMANDSEND = 703	; InspIRCd
Global Const $RPL_HELPSTART = 704	; RatBox
Global Const $RPL_HELPTXT = 705	; RatBox
Global Const $RPL_ENDOFHELP = 706	; RatBox
Global Const $ERR_TARGCHANGE = 707	; RatBox
Global Const $RPL_ETRACEFULL = 708	; RatBox
Global Const $RPL_ETRACE = 709	; RatBox
Global Const $RPL_KNOCK = 710	; RatBox
Global Const $RPL_KNOCKDLVR = 711	; RatBox
Global Const $ERR_TOOMANYKNOCK = 712	; RatBox
Global Const $ERR_CHANOPEN = 713	; RatBox
Global Const $ERR_KNOCKONCHAN = 714	; RatBox
Global Const $ERR_KNOCKDISABLED = 715	; RatBox
Global Const $ERR_TOOMANYINVITE = 715	; Hybrid
Global Const $RPL_INVITETHROTTLE = 715	; Rizon
Global Const $RPL_TARGUMODEG = 716	; RatBox
Global Const $RPL_TARGNOTIFY = 717	; RatBox
Global Const $RPL_UMODEGMSG = 718	; RatBox
Global Const $RPL_OMOTDSTART_ALT = 720	; RatBox
Global Const $RPL_OMOTD_ALT = 721	; RatBox
Global Const $RPL_ENDOFOMOTD = 722	; RatBox
Global Const $ERR_NOPRIVS = 723	; RatBox
Global Const $RPL_TESTMASK = 724	; RatBox
Global Const $RPL_TESTLINE = 725	; RatBox
Global Const $RPL_NOTESTLINE = 726	; RatBox
Global Const $RPL_TESTMASKGECOS = 727	; RatBox
Global Const $RPL_QUIETLIST = 728	; Charybdis
Global Const $RPL_ENDOFQUIETLIST = 729	; Charybdis
Global Const $RPL_MONONLINE = 730	; RatBox
Global Const $RPL_MONOFFLINE = 731	; RatBox
Global Const $RPL_MONLIST = 732	; RatBox
Global Const $RPL_ENDOFMONLIST = 733	; RatBox
Global Const $ERR_MONLISTFULL = 734	; RatBox
Global Const $RPL_RSACHALLENGE2 = 740	; RatBox
Global Const $RPL_ENDOFRSACHALLENGE2 = 741	; RatBox
Global Const $ERR_MLOCKRESTRICTED = 742	; Charybdis
Global Const $ERR_INVALIDBAN = 743	; Charybdis
Global Const $ERR_TOPICLOCK = 744	; InspIRCd?
Global Const $RPL_SCANMATCHED = 750	; RatBox
Global Const $RPL_SCANUMODES = 751	; RatBox
Global Const $RPL_WHOISKEYVALUE = 760	; IRCv3
Global Const $RPL_KEYVALUE = 761	; IRCv3
Global Const $RPL_METADATAEND = 762	; IRCv3
Global Const $ERR_METADATALIMIT = 764	; IRCv3
Global Const $ERR_TARGETINVALID = 765	; IRCv3
Global Const $ERR_NOMATCHINGKEY = 766	; IRCv3
Global Const $ERR_KEYINVALID = 767	; IRCv3
Global Const $ERR_KEYNOTSET = 768	; IRCv3
Global Const $ERR_KEYNOPERMISSION = 769	; IRCv3
Global Const $RPL_XINFO = 771	; Ithildin
Global Const $RPL_XINFOSTART = 773	; Ithildin
Global Const $RPL_XINFOEND = 774	; Ithildin
Global Const $RPL_LOGGEDIN = 900	; Charybdis/Atheme, IRCv3
Global Const $RPL_LOGGEDOUT = 901	; Charybdis/Atheme, IRCv3
Global Const $ERR_NICKLOCKED = 902	; Charybdis/Atheme, IRCv3
Global Const $RPL_SASLSUCCESS = 903	; Charybdis/Atheme, IRCv3
Global Const $ERR_SASLFAIL = 904	; Charybdis/Atheme, IRCv3
Global Const $ERR_SASLTOOLONG = 905	; Charybdis/Atheme, IRCv3
Global Const $ERR_SASLABORTED = 906	; Charybdis/Atheme, IRCv3
Global Const $ERR_SASLALREADY = 907	; Charybdis/Atheme, IRCv3
Global Const $RPL_SASLMECHS = 908	; Charybdis/Atheme, IRCv3
Global Const $ERR_WORDFILTERED = 936	; InspIRCd
Global Const $ERR_CANNOTDOCOMMAND = 972	; Unreal
Global Const $ERR_CANTUNLOADMODULE = 972	; InspIRCd
Global Const $RPL_UNLOADEDMODULE = 973	; InspIRCd
Global Const $ERR_CANNOTCHANGECHANMODE = 974	; Unreal
Global Const $ERR_CANTLOADMODULE = 974	; InspIRCd
Global Const $RPL_LOADEDMODULE = 975	; InspIRCd
Global Const $ERR_LASTERROR_ALT = 975	; Nefarious
Global Const $ERR_NUMERIC_ERR = 999	; Bahamut

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
