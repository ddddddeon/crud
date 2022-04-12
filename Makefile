NAME=crud
GO=/usr/local/go/bin/go

.PHONY: $(NAME)

$(NAME):
	$(GO) build -o bin/crud ./*.go

run:
	docker run -d -p 8080:8080 dddeon/crud:latest

clean:
	$(GO) clean
	docker rmi $$(docker images -a --filter=dangling=true -q) -f

build: $(NAME) prune
	docker build --tag dddeon/crud:latest .

push:
	docker push dddeon/crud:latest

pull:
	docker pull dddeon/crud:latest

prune:
	docker system prune -f
