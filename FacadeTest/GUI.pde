ControlP5 ui;
Range uiAspect;

void initGUI() {
  ui = new ControlP5(this);
  ui.addButton("loadConfig",1,20,height-40,100,20).setLabel("load config");
  ui.addButton("saveConfig",2,140,height-40,100,20).setLabel("save config");
  uiAspect=ui.addRange("aspectRatio",0.2,5, 0.75,1.25, 20,height-60, 200,14);
}

void controlEvent(ControlEvent e) {
  if(e.controller().name().equals("aspectRatio")) {
    println("sdsdsld");
    config.setProperty("window.aspect.min",""+e.controller().arrayValue()[0]);
    config.setProperty("window.aspect.max",""+e.controller().arrayValue()[1]);
    windowAspect.min=e.controller().arrayValue()[0];
    windowAspect.max=e.controller().arrayValue()[1];
  }
}

void loadConfig() {
  String path=FileUtils.showFileDialog(frame,"Choose a facade config...",dataPath(""),new String[] {
    ".txt"
  }
  , java.awt.FileDialog.LOAD);
  if(path!=null) {
    config=new TypedProperties();
    config.load(path);
    // creating parameter ranges as objects
    windowHeight=new FloatRange(config.getFloat("window.height.min",50),config.getFloat("window.height.max",300));
    windowAspect=new FloatRange(config.getFloat("window.aspect.min",0.333),config.getFloat("window.aspect.max",2.0));
    // update GUI controllers
    uiAspect.setLowValue(windowAspect.min);
    uiAspect.setHighValue(windowAspect.max);
    // create facade & segments
    facade=new Facade(config.getInt("facade.width",1000),config.getInt("facade.height",300));
    facade.init();
  }
}

void saveConfig() {
  String path=FileUtils.showFileDialog(frame,"Save facade config as...",dataPath(""),new String[] {
    ".txt"
  }
  , java.awt.FileDialog.SAVE);
  if (path!=null) {
    config.save(createOutput(path),"created at ETHZ workshop "+DateUtils.timeStamp());
    println("saved as: "+path);
  }
}
