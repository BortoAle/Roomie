<p align="center">
  <img src="https://github.com/BortoAle/Roomie/blob/3058384f8726371a34594cf532a7d736f17b9377/RoomieIconRounded.png" alt="Logo" width="80" height="80">
  <h2 align="center">
    Roomie
  </h2>
</p>

<img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/ios17.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/SwiftUI.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/UIKit.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/CloudKit.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/79c191afd3a463f993688531e61d04f7e41002bd/Files/CoreData.svg" alt="SwiftUI" style="height: 30px">

Roomie helps roommates who want to manage common chores by scheduling and assigning tasks. 

<a href="https://youtu.be/JYDTZkBXT7c" target="_blank">
  <img src="https://github.com/BortoAle/Roomie/assets/59065228/10b74848-7574-42fc-999f-1f78feffdc14" alt="GIF">
</a>

[![](https://github.com/matt-novoselov/matt-novoselov/blob/34555effedede5dd5aa24ae675218d989e976cf6/Files/YouTube_Badge.svg)](https://youtu.be/JYDTZkBXT7c)

## Description
Roomie was built using **SwiftUI** to create a visual interface. **UIKit**, along with **ColorKit** (external library), is used to analyze the color content of images and extract the dominant colors from emojis.

**CoreData**, along with **CloudKit**, is used to store and synchronize activities and facilitate collaboration between different participants in the house. Roomie is integrated into Apple’s ecosystem, allowing you to invite your roommates by copying the link to the created house or by sending an invitation to the iMessage group, so that everyone in the group will automatically receive it. All participants in the house can mark activities as completed, modify and adjust schedules for activities, as well as create new activities. You can create several separate houses (groups) with different participants to manage your activities.

The app uses **OpenAI’s** `gpt-3.5-turbo-0125` API to automatically determine an appropriate emoji that would represent the activity's name. For example:

- "Throw Plastic" → 🥤
- "Water Flowers" → 🌸

Roomie includes full localization for four languages:

- 🇺🇸 English
- 🇪🇸 Spanish
- 🇮🇹 Italian
- 🇺🇦 Ukrainian

Our app incorporates accessibility features to assist users, as well as support for light mode.

## Requirements
- iOS 17.0+
- Xcode 15.0+

## Installation
1. Clone repository using the following URL: `https://github.com/BortoAle/Roomie.git`
2. Create Environment File:
   - Create a file named `.env` in the root directory of the source folder.
   - Use the provided `.env.example` file as a template.
3. Replace the placeholder values with your specific configuration:
   - OPEN_AI_API_KEY: Your OpenAI API key obtained from [OpenAI website](https://platform.openai.com)
4. In the Signing & Capabilities of the project create a new iCloud Container. The iCloud Container's bundle identifier should be the same as bundle identifier of the app.

   Example app bundle identifier: `com.example.Roomie`

   Example iCloud Container bundle identifier: `iCloud.com.example.Roomie`
6. Build and run the project in Xcode.

## Dependencies
- [ColorKit](https://github.com/Boris-Em/ColorKit) - UIKit library to find the dominant colors of an image.

<br>

## Credits
Distributed under the MIT license. See **LICENSE** for more information.

Developed with ❤️ by {undefined} Team
