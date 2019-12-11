include ./option.mk

MyVideoEditor_obj=MyVideoEditor/*.o
BFVideoEditor_obj=BFVideoEditor/*.o
MyVideoEditor_png=MyVideoEditor/*.png
MyVideoEditor_nib=MyVideoEditor/*.nib
BFVideoEditor_png=BFVideoEditor/*.png
BFVideoEditor_nib=BFVideoEditor/*.nib



MyVideoEditor.app:main
	mkdir -p MyVideoEditor.app
	mkdir -p MyVideoEditor.app/Contents/Resources
	mkdir -p MyVideoEditor.app/Contents/MacOS
	cp main MyVideoEditor.app/Contents/MacOS
	cp Info.plist MyVideoEditor.app/Contents/
	cp -f $(MyVideoEditor_nib) $(MyVideoEditor_png) $(BFVideoEditor_png) $(BFVideoEditor_nib) MyVideoEditor.app/Contents/Resources
	


main:MyVideoEditor_build BFVideoEditor_obj
	gcc $(MyVideoEditor_obj) $(BFVideoEditor_obj) -o main
	
MyVideoEditor_build:
	$(MAKE) -C MyVideoEditor -f Makefile

BFVideoEditor_obj:
	$(MAKE) -C BFVideoEditor -f Makefile





clean:
	rm -rf $(MyVideoEditor_obj) $(BFVideoEditor_obj) MyVideoEditor.app