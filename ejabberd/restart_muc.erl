echo(on),
restart_module:stop(mod_easemob_cache),
restart_module:start(mod_easemob_cache),
easemob_redis_pool_sup:disconnect(muc),
easemob_redis_pool_sup:connect(muc),
ok.