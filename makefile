.PHONY: preview render clean git

preview:
	quarto preview

render:
	quarto render

clean:
	rm -rf docs .quarto _freeze

git:
	git add . && \
	git commit -m "$(shell hostname)" && \
	git push
