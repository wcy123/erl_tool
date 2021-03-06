echo(on),
case Args of
    [Vsn, DefaultPath] ->
        ok;
    [Vsn] ->
        DefaultPath = "/data/apps/opt"
end,
release_handler:unpack_release("ejabberd_" ++ Vsn),
{ok, _} = file:copy(DefaultPath ++ "/ejabberd/etc/ejabberd/ejabberdctl.cfg",
                    filename:join([DefaultPath ++ "/ejabberd/releases", Vsn, "ejabberdctl.cfg"])),
file:copy(DefaultPath ++ "/ejabberd/etc/ejabberd/" ++ Vsn ++ "/sys.config",
                    filename:join([DefaultPath ++ "/ejabberd/releases", Vsn, "sys.config"])),
{Ok, _} = file:copy(DefaultPath ++ "/ejabberd/etc/ejabberd/inetrc",
                    filename:join([DefaultPath ++ "/ejabberd/releases", Vsn, "inetrc"])),

{ok, _} = file:copy(DefaultPath ++ "/ejabberd/etc/nodetool",
                    filename:join([DefaultPath ++ "/ejabberd/releases", Vsn, "nodetool"])),

try
    release_handler:check_install_release(Vsn, [purge]),
  case release_handler:install_release(Vsn, [{suspend_timeout, infinity}, {code_change_timeout, infinity}]) of
      {ok, OldVsn1, []} ->
          io:format("install release success~n"),
          release_handler:make_permanent(Vsn),
          "GOOD";
      Else ->
          Else
  end
catch
    Class:Error -> {Class, Error}
end.
%% ok = release_handler:make_permanent(Vsn).
