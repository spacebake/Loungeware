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

export type Mutation = {
  __typename?: 'Mutation';
  guestbookCreate: Guestbook;
};

export type MutationGuestbookCreateArgs = {
  input: GuestbookCreateInput;
};

export type Node = {
  id: Scalars['ID'];
};

export type Query = {
  __typename?: 'Query';
  node: Node;
  clientVersion: Scalars['String'];
  user: User;
  me: User;
  guestbooks: Array<Guestbook>;
  guestbook: Guestbook;
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

export type User = Node & {
  __typename?: 'User';
  id: Scalars['ID'];
  displayName: Scalars['String'];
  profilePictureUrl: Scalars['String'];
  roles: Array<DiscordRole>;
};
