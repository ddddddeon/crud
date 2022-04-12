NAME=crud
GO=/usr/local/go/bin/go
VERSION=$$(git log --pretty=oneline -1 | awk '{print $1}' | cut -c 1-7)
.PHONY: $(NAME)

$(NAME):
	$(GO) build -o bin/crud ./*.go

run: 
	docker run -d -p 8080:8080 dddeon/crud:$(VERSION)

clean:
	$(GO) clean
	docker rmi $$(docker images -a --filter=dangling=true -q) -f

build: $(NAME) prune
	docker build --tag dddeon/crud:$(VERSION) .

push: 
	docker push dddeon/crud:$(VERSION)

pull: 
	docker pull dddeon/crud:$(VERSION)

prune:
	docker system prune -f
