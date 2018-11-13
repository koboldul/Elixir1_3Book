{application,sequence,
             [{applications,[kernel,stdlib,elixir,logger,exrm]},
              {description,"sequence"},
              {modules,['Elixir.Sequence.Application',
                        'Elixir.Sequence.Server',
                        'Elixir.Sequence.Server.State',
                        'Elixir.Sequence.Stash',
                        'Elixir.Sequence.SubSupervisor',
                        'Elixir.Sequence.Supervisor']},
              {vsn,"0.2.2"},
              {extra_applications,[logger]},
              {mod,{'Elixir.Sequence.Application',[]}},
              {env,[{initial_number,456}]},
              {registered,['Elixir.Sequence.Server']}]}.