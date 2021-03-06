% input: none
%
% op: stop lager_monitor (inside message_store_sup)
%
% e.g.: ./erl_expect -sname ejabberd@sdb-ali-hangzhou-ejabberd3 -setcookie 'LTBEXKHWOCIRRSEUNSYS' common/stop_lager_monitor.erl

echo(on),

supervisor:terminate_child(message_store_sup, lager_monitor),
supervisor:delete_child(message_store_sup, lager_monitor),
application:set_env(message_store, lager_monitor, false),
ok.
