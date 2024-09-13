import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/models/comment.dart';

final List<Post> dummyPosts = [
  Post(
    postId: 1,
    type: 'fire',
    mediaUrl: 'https://via.placeholder.com/331x234',
    title: '강남구청 근처 화재 발생',
    content:
        "늘 강남역 근처에서 정말 큰일을 겪었어요. 오후 3시쯤 친구랑 강남역에서 만나기로 해서 가는 길이었는데, 갑자기 하늘에 검은 연기가 자욱하게 올라가는 게 보이더라고요. 점점 가까워질수록 연기 냄새도 심해지고, 사람들이 웅성거리며 몰려있는 걸 보니 뭔가 큰일이 난 게 분명했어요.상가 건물에서 불이 난 것 같았어요. 불길이 창문 밖으로 튀어나오는 걸 보고 정말 깜짝 놀랐어요. 소방차가 여러 대 출동해서 물을 뿌리고 있었고, 소방관들이 바쁘게 움직이는 모습이 보였어요. 다행히 인명 피해는 없다는 소리를 들었지만, 현장은 정말 아수라장이었어요.이런 큰 화재를 실제로 보게 되니까 무섭기도 하고, 빨리 진화되길 바라는 마음뿐이었어요. 오늘 강남역은 정말 난리도 아니었어요. 다들 조심하시고, 소방관분들께도 감사한 마음을 전하고 싶어요.. 인근 주민들은 주의하시기 바랍니다.",
    createdAt: DateTime.now(),
    latitude: 37.5172,
    longitude: 127.0473,
    roadAddress: '서울특별시 강남구 삼성동',
    disasterLevel: 'High',
    likesCount: 50,
    commentsCount: 10,
    comments: [
      Comment(
        postId: 1,
        userName: 'User1',
        content: '정말 무섭네요... 다들 조심하세요!',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      Comment(
        postId: 1,
        userName: 'User2',
        content: '안전 조심하세요!',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ],
  ),
  Post(
    postId: 2,
    type: 'traffic',
    mediaUrl: 'https://via.placeholder.com/400x300',
    title: '올림픽대로 대형 교통사고 발생',
    content: '올림픽대로에서 대형 교통사고가 발생하여 교통이 전면 통제되었습니다. 출근길 우회하시기 바랍니다.',
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    latitude: 37.5205,
    longitude: 127.0375,
    roadAddress: '서울특별시 송파구 잠실동',
    disasterLevel: 'Medium',
    likesCount: 80,
    commentsCount: 20,
    comments: [
      Comment(
        postId: 2,
        userName: 'User3',
        content: '이쪽으로 가는 길은 피해야겠네요.',
        createdAt: DateTime.now().subtract(Duration(hours: 3)),
      ),
      Comment(
        postId: 2,
        userName: 'User4',
        content: '운전자들 안전에 유의하세요!',
        createdAt: DateTime.now().subtract(Duration(hours: 4)),
      ),
    ],
  ),
  Post(
    postId: 3,
    type: 'flood',
    title: '대전광역시 홍수 경보',
    content: '대전광역시 일대에 홍수 경보가 발령되었습니다. 저지대 주민들은 대피소로 이동하시기 바랍니다.',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    latitude: 36.3504,
    longitude: 127.3845,
    roadAddress: '대전광역시 서구 둔산동',
    disasterLevel: 'High',
    likesCount: 60,
    commentsCount: 15,
    comments: [
      Comment(
        postId: 3,
        userName: 'User5',
        content: '대피하신 분들 무사히 돌아오시길 바랍니다.',
        createdAt: DateTime.now().subtract(Duration(hours: 5)),
      ),
      Comment(
        postId: 3,
        userName: 'User6',
        content: '상황이 심각하네요. 조심하세요.',
        createdAt: DateTime.now().subtract(Duration(hours: 6)),
      ),
    ],
  ),
  Post(
    postId: 4,
    type: 'earthquake',
    mediaUrl: 'https://via.placeholder.com/400x300',
    title: '부산광역시 지진 발생',
    content:
        '부산광역시 해운대구에서 지진이 발생했습니다. 현재 피해 상황을 조사 중입니다. 주민 여러분, 대피소로 이동해주시기 바랍니다.',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    latitude: 35.1587,
    longitude: 129.1604,
    roadAddress: '부산광역시 해운대구 우동',
    disasterLevel: 'Critical',
    likesCount: 100,
    commentsCount: 30,
    comments: [
      Comment(
        postId: 4,
        userName: 'User7',
        content: '너무 무서워요. 다들 무사하시길.',
        createdAt: DateTime.now().subtract(Duration(hours: 7)),
      ),
      Comment(
        postId: 4,
        userName: 'User8',
        content: '대피소 위치를 알고 있어야겠어요.',
        createdAt: DateTime.now().subtract(Duration(hours: 8)),
      ),
    ],
  ),
  Post(
    postId: 5,
    type: 'explosion',
    mediaUrl: 'https://via.placeholder.com/400x300',
    title: '울산 석유화학단지 폭발 사고',
    content: '오늘 오전 울산 석유화학단지에서 대규모 폭발 사고가 발생했습니다. 현재 인명 피해를 조사 중입니다.',
    createdAt: DateTime.now().subtract(Duration(days: 4)),
    latitude: 35.5391,
    longitude: 129.3114,
    roadAddress: '울산광역시 남구 신정동',
    disasterLevel: 'High',
    likesCount: 150,
    commentsCount: 50,
    comments: [
      Comment(
        postId: 5,
        userName: 'User9',
        content: '너무 충격적입니다. 희생자들이 없길 바랍니다.',
        createdAt: DateTime.now().subtract(Duration(hours: 9)),
      ),
      Comment(
        postId: 5,
        userName: 'User10',
        content: '이 지역에 있는 분들 안전하시길.',
        createdAt: DateTime.now().subtract(Duration(hours: 10)),
      ),
    ],
  ),
  Post(
    postId: 6,
    type: 'storm',
    mediaUrl: 'https://via.placeholder.com/400x300',
    title: '태풍 경보 발령 - 제주도',
    content: '제주도에 태풍 경보가 발령되었습니다. 현재 강한 바람과 비가 몰아치고 있으며, 피해가 예상됩니다.',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    latitude: 33.4996,
    longitude: 126.5312,
    roadAddress: '제주특별자치도 제주시 이도동',
    disasterLevel: 'Medium',
    likesCount: 40,
    commentsCount: 20,
    comments: [
      Comment(
        postId: 6,
        userName: 'User11',
        content: '제주도에 있는 가족들이 걱정되네요.',
        createdAt: DateTime.now().subtract(Duration(hours: 11)),
      ),
      Comment(
        postId: 6,
        userName: 'User12',
        content: '모두 안전하게 대피하세요.',
        createdAt: DateTime.now().subtract(Duration(hours: 12)),
      ),
    ],
  ),
  Post(
    postId: 7,
    type: 'landslide',
    mediaUrl: 'https://via.placeholder.com/400x300',
    title: '강원도 산사태 발생',
    content: '강원도에서 산사태가 발생하여 도로가 끊기고, 몇몇 주택이 피해를 입었습니다. 현재 구조 작업이 진행 중입니다.',
    createdAt: DateTime.now().subtract(Duration(days: 6)),
    latitude: 37.5552,
    longitude: 128.2091,
    roadAddress: '강원도 평창군 대관령면',
    disasterLevel: 'High',
    likesCount: 70,
    commentsCount: 25,
    comments: [
      Comment(
        postId: 7,
        userName: 'User13',
        content: '이런 상황이 너무 안타깝네요. 구조 작업이 잘 되길.',
        createdAt: DateTime.now().subtract(Duration(hours: 13)),
      ),
      Comment(
        postId: 7,
        userName: 'User14',
        content: '모두들 안전하게 대피하시길 바랍니다.',
        createdAt: DateTime.now().subtract(Duration(hours: 14)),
      ),
    ],
  ),
];
