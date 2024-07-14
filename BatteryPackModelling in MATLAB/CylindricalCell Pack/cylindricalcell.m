import simscape.battery.builder.*;
cylindricalGeometry = CylindricalGeometry(Height = simscape.Value(0.07,"m"),...
    Radius = simscape.Value(0.0105,"m"));
cylindricalGeometry;
cylindricalGeometry.Height;
cylindricalGeometry.Height = simscape.Value(0.08,"m");
batteryCell = Cell(Geometry = cylindricalGeometry);
f = uifigure(Color="w");
tl = tiledlayout(1,1,"Parent",f,"TileSpacing","Compact");
batteryImage = BatteryChart(Parent = tl, Battery = batteryCell);
batteryParallelAssembly = ParallelAssembly(Cell = batteryCell,...
    NumParallelCells = 4, ...
    Rows = 4, ...
    Topology = "Square", ...
    ModelResolution = "Detailed");
batteryImage = BatteryChart(Parent = tl, Battery = batteryParallelAssembly);
batteryParallelAssembly.ModelResolution = "Lumped";
batteryImage = BatteryChart(Parent = tl, Battery = batteryParallelAssembly);
BatteryModule = Module(ParallelAssembly = batteryParallelAssembly,...
    NumSeriesAssemblies = 13, ...
    InterParallelAssemblyGap = simscape.Value(0.005,"m"), ...
    ModelResolution = "Detailed", ...
    AmbientThermalPath = "CellBasedThermalResistance");
BatteryModule;
batteryImage = BatteryChart(Parent = tl, Battery = BatteryModule);
batteryParallelAssembly.ModelResolution = "Lumped";
BatteryModule.ModelResolution = "Lumped";
batteryImage = BatteryChart(Parent = tl, Battery = BatteryModule);
BatteryModule.ModelResolution = "Grouped";
BatteryModule.SeriesGrouping = ones(1,13);
BatteryModule.SeriesGrouping = [1 11 1];
buildBattery(BatteryModule,"LibraryName","moduleLibrary");







