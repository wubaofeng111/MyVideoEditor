include ../option.mk

.PHONY:MyVideoEditor

MyVideoEditor:AppDelegate.o BFCollectionViewItem.o main.o BFCollectionViewItem.nib
	echo build MyVideoEditor


AppDelegate.o:AppDelegate.h AppDelegate.m ../BFVideoEditor/BFVideoEditor.h
	$(bfcc) -c AppDelegate.m -o AppDelegate.o

BFCollectionViewItem.o:BFCollectionViewItem.h BFCollectionViewItem.m
	$(bfcc) -c BFCollectionViewItem.m -o BFCollectionViewItem.o

BFCollectionViewItem.nib:
	ibtool --compile BFCollectionViewItem.nib BFCollectionViewItem.xib

main.o:
	$(bfcc) -c main.m -o main.o

