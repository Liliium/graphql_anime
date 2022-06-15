class GraphQuery {
  GraphQuery(this.page);
  final int page;

  String get query => """
{
  Page(perPage: 10, page: $page) {
    media {
      title {
        english
        native
      }
      status
      episodes
      startDate {
        year
        month
      }
      endDate {
        year
        month
      }
      characters(role: MAIN) {
        nodes{
          name {
            userPreferred
          }
          image {
            large
          }
        }
      }
    }
  }
}
""";
}
