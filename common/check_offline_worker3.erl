echo(off),
GetQlen = 
fun({N, Pid})
      when is_pid(Pid) ->
	try
	    case is_process_alive(Pid) of
		false ->
		    {true, {Pid, N}};
		true ->
		    false
	    end
	catch
	    _Class:_Type ->
		false
	end;
   (_) ->
	false
end,
M = lists:filtermap(GetQlen, ets:tab2list(offline)),
io:format("~p~n", [M]),
if erlang:length(M) > 0 ->
	supervisor:terminate_child(message_store_sup, offline),
	supervisor:restart_child(message_store_sup, offline);
    true ->
        ok
end,
ok.
