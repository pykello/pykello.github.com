deploy:
	./deploy.sh

build:
	cd fa && raco frog -b
	raco frog -b

preview:
	raco frog -p

clean:
	raco frog --clean
	rm -f index.html sitemap.txt

