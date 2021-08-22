export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = {
  [K in keyof T]: T[K];
};
export type MakeOptional<T, K extends keyof T> = Omit<T, K> &
  { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> &
  { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
};

export type AddMicrogameRatingInput = {
  microgameId: Scalars['String'];
  comment: Scalars['String'];
  difficulty: Scalars['Float'];
  isFavorited: Scalars['Boolean'];
};

export type DiscordRole = {
  __typename?: 'DiscordRole';
  id: Scalars['ID'];
  displayName: Scalars['String'];
  colorHex: Scalars['String'];
};

export type Guestbook = Node & {
  __typename?: 'Guestbook';
  id: Scalars['ID'];
  authorUserId: Scalars['String'];
  text: Scalars['String'];
  createdAt: Scalars['Float'];
  author: User;
};

export type GuestbookCreateInput = {
  text: Scalars['String'];
};

export type Microgame = Node & {
  __typename?: 'Microgame';
  id: Scalars['ID'];
  gameSlug: Scalars['String'];
  authorSlug: Scalars['String'];
  author: User;
  ratings: Array<MicrogameRating>;
  hasMyRating: Scalars['Boolean'];
};

export type MicrogameRating = Node & {
  __typename?: 'MicrogameRating';
  id: Scalars['ID'];
  isFavorited: Scalars['Boolean'];
  difficulty: Scalars['Float'];
  comment: Scalars['String'];
  createdAt: Scalars['Float'];
  editedAt: Scalars['Float'];
  author: User;
};

export type Mutation = {
  __typename?: 'Mutation';
  guestbookCreate: Guestbook;
  addMicrogameRating: MicrogameRating;
};

export type MutationGuestbookCreateArgs = {
  input: GuestbookCreateInput;
};

export type MutationAddMicrogameRatingArgs = {
  input: AddMicrogameRatingInput;
};

export type Node = {
  id: Scalars['ID'];
};

export type PageVisit = Node & {
  __typename?: 'PageVisit';
  id: Scalars['ID'];
  route: Scalars['String'];
  visits: Scalars['Float'];
};

export type Query = {
  __typename?: 'Query';
  node: Node;
  clientVersion: Scalars['String'];
  user: User;
  me: User;
  guestbooks: Array<Guestbook>;
  guestbook: Guestbook;
  pageVisits: PageVisit;
  microgame: Microgame;
  microgamesFromAuthor: Microgame;
};

export type QueryNodeArgs = {
  id: Scalars['String'];
};

export type QueryUserArgs = {
  id: Scalars['String'];
};

export type QueryGuestbookArgs = {
  id: Scalars['String'];
};

export type QueryPageVisitsArgs = {
  route: Scalars['String'];
};

export type QueryMicrogameArgs = {
  gameSlug: Scalars['String'];
};

export type QueryMicrogamesFromAuthorArgs = {
  userId: Scalars['String'];
};

export type User = Node & {
  __typename?: 'User';
  id: Scalars['ID'];
  displayName: Scalars['String'];
  profilePictureUrl: Scalars['String'];
  roles: Array<DiscordRole>;
};
