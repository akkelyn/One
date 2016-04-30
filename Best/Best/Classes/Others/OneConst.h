#import <UIKit/UIKit.h>

typedef enum {
    OneTopicTypeAll = 1,
    OneTopicTypePicture = 10,
    OneTopicTypeTypeWord = 29,
    OneTopicTypeVoice = 31,
    OneTopicTypeVideo = 41
} OneTopicType;

UIKIT_EXTERN CGFloat const OneTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const OneTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const OneTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const OneTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const OneTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const OneTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const OneTopicCellPictureBreakH;

/** OneUser模型-性别属性值 */
UIKIT_EXTERN NSString * const OneUserSexMale;
UIKIT_EXTERN NSString * const OneUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const OneTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const OneTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const OneSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const OneSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const OneTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const OneTagH;