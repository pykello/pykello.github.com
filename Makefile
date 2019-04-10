deploy:
	./deploy.sh

clean:
	raco frog --clean
	rm -f index.html sitemap.txt

