This page contains an example of how to describe the API structure

# Users
## Request
```GET /users?userId=long ```

## Response
```
{[
      {
          "userId": long,
          "name"  : string,
          "age"   : int
      }
]}
```
# News
## Request
```GET /news_preview?i1=long&i2=long```

## Response
```
{[
      {
          "newsId"  : long,
          "date"    : string,
          "time"    : string,
          "title"   : string,
          "likeNum" : long
      }
]}
```
# Matches
## Request
```GET /matches_preview?```

## Response
```
{[
      {
          "matchId"   : long,
          "started"   : boolean,
          "startTime" : string,
          "teamScore1": int,
          "teamScore2": int,
          "teamName1" : string,
          "teamName2" : long
      }
]}
```
# Stories
## Request
```GET /stories?```

## Response
```
{[
      {
        "userId" : Int,
        "userFirstName"  : String,
        "userSecondName" : String,
        "previewUrl" : String
      }
]}
```
