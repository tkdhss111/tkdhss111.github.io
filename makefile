.PHONY: render preview publish clean

render:
	quarto render

preview:
	quarto preview

# 提出用。ソースをGitHubに保存し、サイトを公開する。
# 初回はここで gh-pages ブランチが作られる。
publish:
	git add -A && \
	git commit -m "Update" && \
	git push && \
	quarto publish gh-pages

clean:
	rm -rf docs .quarto _freeze
