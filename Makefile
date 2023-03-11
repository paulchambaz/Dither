run:
	@processing-java --sketch=Dither --run

build:
	@processing-java --sketch=Dither --output=build --export

install: build
	@mkdir -p /usr/share/Dither
	@cp -r build/* /usr/share/Dither
	@chmod 755 /usr/share/Dither -R
	@printf "#!/bin/bash\ncd /usr/share/Dither && ./Dither\n" > /usr/bin/Dither
	@chmod 755 /usr/bin/Dither

uninstall:
	@rm -fr /usr/share/Dither
	@rm /usr/bin/Dither

clean:
	@rm -fr build
