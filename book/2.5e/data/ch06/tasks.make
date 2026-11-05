.PHONY: clean publish docker-run

clean:
	rm book/2e/book.md book/2e/render*.rds

publish:
	(cd www && hugo) && netlify deploy --prod --dir www/public

docker-run:
	docker run -it --rm -v $$(pwd)/book/2e/data:/data -p 8000:8000 datasciencetoolbox/dsatcl2e:latest
