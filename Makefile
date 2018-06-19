QMAKE=/usr/bin/qmake

INSTALLDIR=$(HOME)/XyGrib
MACQTBIN=/usr/local/Qt-5.3.2/bin/

all: XyGrib

SRC= src/*.h src/*.cpp src/*/*.h src/*/*.cpp

mac: $(SRC)
	rm -f  ./XyGrib
	rm -fr ./XyGrib.app
	rm -f  src/Makefile
	cd src; $(MACQTBIN)/qmake; make -j6

macclean:
	rm -f  XyGrib
	rm -fr XyGrib.app
	rm -f  src/XyGrib
	rm -f  src/release/XyGrib.exe
	cd src;	$(MACQTBIN)/qmake; make clean

clean:
	rm -f  XyGrib
	rm -fr XyGrib.app
	rm -f  src/XyGrib
	rm -f  src/release/XyGrib.exe
	cd src;	$(QMAKE); make clean

veryclean: clean
	cd src/g2clib-1.6.0; make clean
	rm -f src/openjpeg-2.3.0/build

XyGrib: $(SRC)
	@ echo
	rm -f ./XyGrib
	cd src; $(QMAKE); make -j6
	@ echo "-----------------------------------"
	@ echo "#!/bin/bash" >> ./XyGrib
	@ echo "cd `pwd`" >> ./XyGrib
	@ echo 'src/XyGrib $$*' >> ./XyGrib
	@ chmod 755 ./XyGrib

install: XyGrib
	mkdir -p $(INSTALLDIR)
	mkdir -p $(INSTALLDIR)/bin
	cp -a data $(INSTALLDIR)
	cp -a grib $(INSTALLDIR)
	rm -f ./XyGrib
	rm -f $(INSTALLDIR)/bin/XyGrib
	cp  -a src/XyGrib $(INSTALLDIR)/bin
	echo "#!/bin/bash" >> ./XyGrib
	echo "cd $(INSTALLDIR)" >> ./XyGrib
	echo 'bin/XyGrib $$*' >> ./XyGrib
	chmod 755 ./XyGrib
	cp -af XyGrib $(INSTALLDIR)
