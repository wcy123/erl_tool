% input: Muc
%
% op: get Muc members
%
% e.g.: ./erl_expect -sname ejabberd@sdb-ali-hangzhou-ejabberd3 -setcookie 'LTBEXKHWOCIRRSEUNSYS' common/get_room_blocked.erl Muc
echo(off),
io:format("Input Muc Room like easemob-demo#chatdemoui_group1~n", []),
[MucList] = Args,
Muc = list_to_binary(MucList),
MucBlocked = mod_muc_admin:get_room_blocked(Muc, <<"conference.easemob.com">>),
io:format("MucBlocked:~p ~n", [MucBlocked]),
Mute = mod_easemob_cache_query_cmd:get_mute(Muc),
io:format("Mute:~p ~n", [Mute]),
ok.
