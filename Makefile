NAME=crud
GO=/usr/local/go/bin/go
VERSION=$$(cat VERSION)
.PHONY: $(NAME)

$(NAME):
	$(GO) build -o bin/crud ./*.go

run: 
	docker run -d -p 8080:8080 dddeon/crud:$(VERSION)

clean:
	$(GO) clean
	docker rmi $$(docker images -a --filter=dangling=true -q) -f

build: $(NAME) prune
	git checkout master; \
	git log --pretty=oneline -1 | awk '{print }' | cut -c 1-7 > VERSION; \
	docker build --tag dddeon/crud:$(VERSION) .; \
	git add VERSION; git commit -n -m "bump version to $(VERSION)"; \
	git push origin master

push: 
	docker push dddeon/crud:$(VERSION)

pull: 
	docker pull dddeon/crud:$(VERSION)

prune:
	docker system prune -f
