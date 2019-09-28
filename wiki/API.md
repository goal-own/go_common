This page contains an example of how to describe the API structure

# Users
## Request
```GET /users?userId=long ```

## Response
```
{
      "data":[{
          "userId": long,
          "name"  : string,
          "age"   : int
      },
      "errorCode":Int
]}
```
# News
## Request
```GET /news_preview?i1=long&i2=long```

## Response
```
{
      "data":[{
          "newsId"  : long,
          "date"    : string,
          "time"    : string,
          "title"   : string,
          "likeNum" : long
      }],
      "errorCode":Int
}
```
# Matches
## Request
```GET /matches_preview?```

## Response
```
{
      "data":[{
          "matchId"   : long,
          "started"   : boolean,
          "startTime" : string,
          "teamScore1": int,
          "teamScore2": int,
          "teamName1" : string,
          "teamName2" : long
      }],
      "errorCode":Int

}
```
# Stories
## Request
```GET /stories?```

## Response
```
{
      "data":[{
              "userId" : Int,
              "userFirstName"  : String,
              "userSecondName" : String,
              "previewUrl" : String
      }],
      "errorCode":Int
}
```

# Image
## Request
```POST /media/submit-image?session_id='1234'```
body: contain binary file
header: content-type=Image
## Response
```
{
      "data": null,
      "errorCode":Int
}
```
