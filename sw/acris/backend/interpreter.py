import sys

class Command:
    def __init__(self, name, acris):
        self.name = name;
        self.acris = acris;

    def execute(self, args, params):
        try:
            return self._do_execute(args, params);
        except Exception as e:
            sys.stderr.write("Command Failed: %s\n" % self.name);
            sys.stderr.write("%r" % e);
            return None;

    def _do_execute(self, args, params):
        return False;


class CommandStart(Command):
    def _do_execute(self, args, params):
        plugin = args[0];

        if len(args) == 2 and args[1] == 'force':
            do_force = True;
        else:
            do_force = False;

        self.acris.update_plugin_params(plugin, params);
        self.acris.start_or_restart_plugin(plugin, force=do_force);

        return True;


class CommandStop(Command):
    def _do_execute(self, args, params):
        plugin = args[0];

        self.acris.stop_plugin(plugin);
        return True;


class CommandStatus(Command):
    def _do_execute(self, args, params):
        plugin = args[0];
        op = args[1];

        if op == 'state':
            plugin_enabled = self.acris.get_plugin_state(plugin);
            if plugin_enabled:
                return "on";
            else:
                return "off";

        elif op == 'params':
            plugin_params = self.acris.get_plugin_params(plugin);

            if 'param' not in params:
                return plugin_params;
            else:
                if 'format' in params:
                    fmt = params['format']
                else:
                    fmt = None;

                plugin_param_name = params['param'];
                plugin_param_value = plugin_params[plugin_param_name];

                # TODO: find a better way to allow arbitrary format outputs
                if fmt == 'hex':
                    return plugin_param_value.as_hex();
                else:
                    return plugin_param_value;

        else:
            return None;


class CommandStopAll(Command):
    def _do_execute(self, args, params):
        self.acris.stop_all_plugins();
        return True;


class CommandList(Command):
    def _do_execute(self, args, params):
        if len(args) != 1:
            list_type = 'all_plugins';
        else:
            list_type = args[0];

        if list_type == 'all_plugins':        return self.acris.list_all_plugins();
        elif list_type == 'active_plugins':   return self.acris.list_active_plugins();
        elif list_type == 'active_addresses': return self.acris.list_active_addresses();
        else: return [];


class CommandRefresh(Command):
    def _do_execute(self, args, params):
        self.acris.refresh_plugins();
        return True;


class CommandDie(Command):
    def _do_execute(self, args, params):
        self.acris.die();
        return True;


command_map = {
        'start'   : CommandStart,
        'stop'    : CommandStop,
        'status'  : CommandStatus,
        'stopall' : CommandStopAll,
        'list'    : CommandList,
        'refresh' : CommandRefresh,
        'die'     : CommandDie,
        };


class CommandInterpreter:
    def __init__(self, acris):
        # connect to main ACRIS object in order to enact commands
        self.acris = acris;

        # build commands
        self.commands = {};
        for command in command_map:
            self.commands[command] = command_map[command](command, self.acris);

    def execute(self, command, args, params):
        print("Received Command: %s" % command);
        print("    Args:   %r" % args);
        print("    Params: %r" % params);

        if command in self.commands:
            return self.commands[command].execute(args, params);
        else:
            return False;
