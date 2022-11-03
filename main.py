import databases
import strawberry
from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter
from typing import List
from datetime import date

DATABASE_URL = "postgresql://postgres:12345@localhost/prueba"

database = databases.Database(DATABASE_URL)


@strawberry.input
class PostInput:
    id: int
    description: str
    video_url: str
    created_at: date

@strawberry.input
class CommentsInput:
    id: int
    description: str   
    created_at: date
    post_id: int

@strawberry.type
class Post:
    id: int
    description: str
    video_url: str
    created_at: date

@strawberry.type
class Comments:
    id: int
    description: str   
    created_at: date
    post_id: int

async def read_posts() -> List[Post]:
    query = "SELECT * FROM posts"
    rows = await database.fetch_all(query)

    return [Post(id=r.id, description=r.description, video_url=r.video_url, created_at=r.created_at) for r in rows]


async def read_comments() -> List[Comments]:
    query = "SELECT * FROM comments"
    rows = await database.fetch_all(query)

    return [Comments(id=r.id, description=r.description, created_at=r.created_at, post_id=r.post_id) for r in rows]
    

async def read_posts_id(id: int) -> Post:    
        query = "SELECT * FROM posts WHERE id=%s"%id
        rows = await database.fetch_one(query)

        return Post(id=rows.id, description=rows.description, video_url=rows.video_url, created_at=rows.created_at)
   

async def read_comments_id(id: int) -> Comments:
    query = "SELECT * FROM comments WHERE post_id=%s"%id
    rows = await database.fetch_one(query)

    return Comments(id=rows.id, description=rows.description, created_at=rows.created_at, post_id=rows.post_id)


@strawberry.type
class Query:
    posts: List[Post] = strawberry.field(resolver=read_posts)
    comments: List[Comments] = strawberry.field(resolver=read_comments)
    posts_id: Post = strawberry.field(resolver=read_posts_id)
    comments_id: Comments = strawberry.field(resolver=read_comments_id)


@strawberry.type
class Mutation:
    @strawberry.mutation
    async def create_post(self, data: PostInput) -> Post:
        row = await database.fetch_one("INSERT INTO posts(id, description, video_url, created_at) values(:id, :description, :video_url, :created_at) returning *",
                                       values={"id": data.id, "description": data.description, "video_url": data.video_url, "created_at": data.created_at})
        return Post(id=row.id, description=row.description, video_url=row.video_url, created_at=row.created_at)
   
    @strawberry.mutation
    async def create_comments(self, data: CommentsInput) -> Comments:
        row = await database.fetch_one("INSERT INTO comments(id, description, created_at, post_id) values(:id, :description, :created_at, :post_id) returning *",
                                       values={"id": data.id, "description": data.description, "created_at": data.created_at, "post_id":data.post_id})
        return Comments(id=row.id, description=row.description, created_at=row.created_at,  post_id=row.post_id)


schema = strawberry.Schema(Query, Mutation)

graphql_app = GraphQLRouter(schema)

app = FastAPI()

app.include_router(graphql_app, prefix="/graphql")


@app.on_event("startup")
async def startup():
    await database.connect()


@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()
