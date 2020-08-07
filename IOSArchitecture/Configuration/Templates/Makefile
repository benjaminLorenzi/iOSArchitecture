XCODE_USER_TEMPLATES_DIR=~/Library/Developer/Xcode/Templates/File\ Templates
PROJECT_NAME="AmexGBTiOSArchitecture"
SUBDIRS=AmexGBTiOSArchitecture

install: 
	@mkdir -p $(XCODE_USER_TEMPLATES_DIR);
	@rm -fR $(XCODE_USER_TEMPLATES_DIR)/"$(SUBDIRS)";
	@cp -R "$(PROJECT_NAME)" $(XCODE_USER_TEMPLATES_DIR);
	@echo "$(PROJECT_NAME) install is Done.";
	return 0;

