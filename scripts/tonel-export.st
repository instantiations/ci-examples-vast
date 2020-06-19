| writer path |
path := (CfsPath named: '<insert path to root ci-examples local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'Seaside Traffic Light Builder';
  addLatestConfigurationMapNamed: 'Seaside Traffic Light Runtime';
	addLatestConfigurationMapNamed: 'Seaside Traffic Light XD';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
