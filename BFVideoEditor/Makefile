include ../option.mk

.PHONY:BFVideoEditor

BFVideoEditor:BFVideoEditor.o VideoFileItem.o
	echo "build success"

BFVideoEditor.o:BFVideoEditor.m BFVideoEditor.h
	$(bfcc) -c BFVideoEditor.m -o BFVideoEditor.o

VideoFileItem.o:VideoFileItem.m VideoFileItem.h
	$(bfcc) -c VideoFileItem.m -o VideoFileItem.o


